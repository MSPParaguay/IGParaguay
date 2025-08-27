#!/usr/bin/env python3
"""
Upload all FHIR resources found in a folder to a FHIR server using HTTP PUT.
The resource id is taken from each resource's "id" element, and the target URL is:
  {base_url}/{resourceType}/{id}

Supported input files in the folder (non-recursive by default):
- .json  : Single FHIR resource, Bundle, or a JSON array of resources
- .ndjson: Newline-delimited JSON; each line is a single FHIR resource

Usage:
  python fhir_put_folder.py --base-url https://fhir.example.com/fhir \
                            --folder ./resources \
                            --token YOUR_BEARER_TOKEN

Optional:
  --basic-user USER --basic-pass PASS    # Basic auth instead of Bearer
  --recursive                            # Walk subfolders
  --timeout 20                           # Seconds per request (default 20)
  --dry-run                              # Parse and show target URLs, do not send
  --verify-ssl false                     # Disable TLS verification (NOT recommended)
  --rate-limit 0.1                       # Sleep seconds between requests
  --only-types Patient,Observation       # Comma list to filter resourceType
  --retries 2                            # Retries on 5xx/timeout (default 2)
"""

import argparse
import json
import sys
import time
import os
from pathlib import Path
from typing import Dict, Any, Iterable, Tuple, Optional, List

import requests


def parse_bool(s: str) -> bool:
    return s.lower() in {"1", "true", "t", "yes", "y"}


def iter_files(folder: Path, recursive: bool) -> Iterable[Path]:
    if recursive:
        yield from (p for p in folder.rglob("*") if p.is_file() and p.suffix.lower() in {".json", ".ndjson"})
    else:
        yield from (p for p in folder.iterdir() if p.is_file() and p.suffix.lower() in {".json", ".ndjson"})


def load_json_file(path: Path) -> Iterable[Dict[str, Any]]:
    """
    Yields FHIR resources from a .json file.
    The file can contain:
      - a single resource (dict)
      - a Bundle (resourceType == "Bundle"): will yield each entry.resource
      - an array of resources (list)
    """
    with path.open("r", encoding="utf-8") as f:
        try:
            data = json.load(f)
        except json.JSONDecodeError as e:
            raise RuntimeError(f"Invalid JSON in {path}: {e}") from e

    if isinstance(data, dict):
        if data.get("resourceType") == "Bundle" and isinstance(data.get("entry"), list):
            for e in data["entry"]:
                res = e.get("resource")
                if isinstance(res, dict):
                    yield res
        else:
            yield data
    elif isinstance(data, list):
        for item in data:
            if isinstance(item, dict):
                yield item
    else:
        raise RuntimeError(f"Unsupported JSON root in {path}: {type(data).__name__}")


def load_ndjson_file(path: Path) -> Iterable[Dict[str, Any]]:
    with path.open("r", encoding="utf-8") as f:
        for i, line in enumerate(f, 1):
            line = line.strip()
            if not line:
                continue
            try:
                data = json.loads(line)
            except json.JSONDecodeError as e:
                raise RuntimeError(f"Invalid NDJSON at {path}:{i}: {e}") from e
            if isinstance(data, dict):
                yield data


def iter_resources_from_file(path: Path) -> Iterable[Dict[str, Any]]:
    if path.suffix.lower() == ".json":
        yield from load_json_file(path)
    elif path.suffix.lower() == ".ndjson":
        yield from load_ndjson_file(path)
    else:
        return


def build_target_url(base_url: str, resource: Dict[str, Any]) -> str:
    rtype = resource.get("resourceType")
    rid = resource.get("id")
    if not rtype or not rid:
        raise ValueError("Resource must contain 'resourceType' and 'id'")
    return f"{base_url.rstrip('/')}/{rtype}/{rid}"


def put_with_retries(
    url: str,
    resource: Dict[str, Any],
    headers: Dict[str, str],
    timeout: int,
    verify_ssl: bool,
    retries: int,
    rate_limit: float,
    dry_run: bool,
) -> Tuple[int, Optional[str]]:
    body = json.dumps(resource, ensure_ascii=False)
    if dry_run:
        return (0, "DRY-RUN")
    for attempt in range(retries + 1):
        try:
            resp = requests.put(url, data=body.encode("utf-8"), headers=headers, timeout=timeout, verify=verify_ssl)
            status = resp.status_code
            text = resp.text
            # Retry on timeouts handled by except, and server errors 5xx
            if status >= 500 and attempt < retries:
                time.sleep(1.5 * (attempt + 1))
                continue
            return (status, text)
        except requests.exceptions.RequestException as e:
            if attempt < retries:
                time.sleep(1.5 * (attempt + 1))
                continue
            return (-1, f"REQUEST ERROR: {e}")
        finally:
            if rate_limit > 0:
                time.sleep(rate_limit)
    return (-1, "Unknown error")


def main():
    ap = argparse.ArgumentParser(description="Upload FHIR resources from folder using HTTP PUT.")
    ap.add_argument("--base-url", required=True, help="Base FHIR server URL, e.g., https://server/fhir")
    ap.add_argument("--folder", required=True, help="Folder containing .json/.ndjson files")
    ap.add_argument("--token", help="Bearer token for Authorization header")
    ap.add_argument("--basic-user", help="Basic auth username (use instead of --token)")
    ap.add_argument("--basic-pass", help="Basic auth password (use instead of --token)")
    ap.add_argument("--recursive", action="store_true", help="Recurse into subfolders")
    ap.add_argument("--timeout", type=int, default=20, help="Request timeout seconds")
    ap.add_argument("--dry-run", action="store_true", help="Print targets but do not send requests")
    ap.add_argument("--verify-ssl", type=parse_bool, default=True, help="Verify TLS certificates (true/false)")
    ap.add_argument("--rate-limit", type=float, default=0.0, help="Seconds to sleep between requests")
    ap.add_argument("--only-types", help="Comma-separated list to filter resourceType (e.g., Patient,Observation)")
    ap.add_argument("--retries", type=int, default=2, help="Number of retries on failure/timeouts (default 2)")

    args = ap.parse_args()

    base_url = args.base_url
    folder = Path(args.folder).expanduser().resolve()

    if not folder.exists() or not folder.is_dir():
        print(f"Folder not found: {folder}", file=sys.stderr)
        sys.exit(2)

    only_types: Optional[List[str]] = None
    if args.only_types:
        only_types = [x.strip() for x in args.only_types.split(",") if x.strip()]

    headers = {
        "Content-Type": "application/fhir+json; charset=utf-8",
        "Accept": "application/fhir+json",
    }

    auth = None
    if args.token:
        headers["Authorization"] = f"Bearer {args.token}"
    elif args.basic_user and args.basic_pass:
        # requests can do basic auth via auth=(user, pass), but also OK to prefill header
        from requests.auth import HTTPBasicAuth
        auth = HTTPBasicAuth(args.basic_user, args.basic_pass)

    total = 0
    success = 0
    skipped = 0
    errors = 0

    for path in iter_files(folder, args.recursive):
        try:
            for res in iter_resources_from_file(path):
                rtype = res.get("resourceType")
                rid = res.get("id")

                if only_types and rtype not in only_types:
                    skipped += 1
                    print(f"[SKIP] {path.name}: resourceType {rtype} not in filter")
                    continue

                if not rtype or not rid:
                    skipped += 1
                    print(f"[SKIP] {path.name}: missing resourceType or id")
                    continue

                url = build_target_url(base_url, res)
                total += 1
                if args.dry_run:
                    print(f"[DRY-RUN] PUT {url}")
                    continue

                # Merge headers with optional auth via requests param
                try:
                    body = json.dumps(res, ensure_ascii=False).encode("utf-8")
                except Exception as e:
                    errors += 1
                    print(f"[ERROR] {path.name}: JSON encoding failed: {e}")
                    continue

                try:
                    resp = requests.put(url, data=body, headers=headers, timeout=args.timeout, verify=args.verify_ssl, auth=auth)
                    status = resp.status_code
                    if 200 <= status < 300:
                        success += 1
                        print(f"[OK {status}] {url}")
                    else:
                        errors += 1
                        snippet = resp.text[:400].replace("\n", " ")
                        print(f"[FAIL {status}] {url} :: {snippet}")
                except requests.exceptions.RequestException as e:
                    errors += 1
                    print(f"[ERROR] {url}: {e}")
                finally:
                    if args.rate_limit > 0:
                        time.sleep(args.rate_limit)

        except Exception as e:
            errors += 1
            print(f"[ERROR] Reading {path.name}: {e}")

    print("\n=== SUMMARY ===")
    print(f"Total candidates: {total + skipped}")
    print(f"Uploaded (2xx):  {success}")
    print(f"Skipped:         {skipped}")
    print(f"Errors:          {errors}")

if __name__ == "__main__":
    main()
