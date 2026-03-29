import requests
import pandas as pd
import urllib3

# ----------------------------------------------------
# CONFIG
# ----------------------------------------------------
BASE_URL = "https://eciemaps.mscbs.gob.es/ecieMaps/servlet/Cie10Arbol?noMostrar=0&tipo=1&codigo={}"

# Capítulos CIE-10-ES (01–22)
capitulos = [f"{i:02d}" for i in range(1, 23)]

# Lista donde almacenaremos todos los códigos
datos = []

# ----------------------------------------------------
# FUNCIÓN RECURSIVA PARA RECORRER TODA LA JERARQUÍA
# ----------------------------------------------------
def recorrer_nodos(nodo, capitulo):
    """
    Recorre un nodo y todos sus hijos de forma recursiva
    """
    codigo = nodo.get("codigo")
    descripcion = nodo.get("descripcion")

    if codigo and descripcion:
        datos.append({
            "Capítulo": capitulo,
            "Código": codigo,
            "Descripción": descripcion
        })

    # Si el nodo tiene hijos, los recorremos
    hijos = nodo.get("listaHijo", [])
    for hijo in hijos:
        recorrer_nodos(hijo, capitulo)

# ----------------------------------------------------
# DESCARGA COMPLETA
# ----------------------------------------------------
print("Descargando CIE-10-ES (categorías + subcategorías)...\n")

for cap in capitulos:
    print(f"→ Capítulo {cap}...")

    urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)


    url = BASE_URL.format(cap)
    r = requests.get(url, verify=False)

    if r.status_code != 200:
        print(f"  ERROR al descargar capítulo {cap}")
        continue

    estructura = r.json()

    # El nodo raíz del capítulo contiene listaHijo con todos los bloques
    for nodo in estructura.get("listaHijo", []):
        recorrer_nodos(nodo, cap)

print(f"\nTotal de códigos obtenidos: {len(datos)}")

# ----------------------------------------------------
# EXPORTAR A EXCEL
# ----------------------------------------------------
df = pd.DataFrame(datos)
df = df.sort_values("Código")  # Orden

output_file = "cie10_es_completo_con_subcategorias.xlsx"
df.to_excel(output_file, index=False)

print(f"\nArchivo generado: {output_file}")
