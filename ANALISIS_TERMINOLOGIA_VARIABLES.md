# 📊 Análisis de Terminología y Variables Configurables
## IGParaguay - FHIR Implementation Guide

**Generado:** 10 de abril de 2026  
**Proyecto:** HL7 FHIR Implementation Guide Para Paraguay  
**Versión IG:** 0.1  
**Versión FHIR:** 4.0.1

---

## 📑 Tabla de Contenidos
1. [Configuración del Proyecto](#-configuración-del-proyecto)
2. [Terminología Definida](#-terminología-definida)
3. [Variables Configurables](#-variables-configurables)
4. [Perfiles FHIR](#-perfiles-fhir)
5. [Ejemplos de Uso](#-ejemplos-de-uso)

---

## ⚙️ Configuración del Proyecto

### 1. Configuración Principal - `sushi-config.yaml`

**Ubicación:** Raíz del proyecto

**Variables críticas:**

| Variable | Valor Actual | Descripción | Tipo |
|----------|-------------|-------------|------|
| `id` | `hl7.fhir.py.CorePY` | Identificador único del Implementation Guide | String |
| `canonical` | `https://mspbs.gov.py/fhir` | URL canónica base para todas las referencias | URL |
| `version` | `0.1` | Versión del IG | SemVer |
| `fhirVersion` | `4.0.1` | Versión de FHIR utilizada | SemVer |
| `releaseLabel` | `ci-build` | Etiqueta de compilación | String |
| `copyrightYear` | `2023+` | Año de copyright | Integer |
| `publisher` | `MSPBS Paraguay` | Organización publicadora | String |
| `jurisdictionCodeableConcept` | `urn:iso:std:iso:3166:-2:PY` | Jurisdicción: Paraguay ISO 3166 | CodeableConcept |

**Dependencias declaradas:**

```yaml
dependencies:
  hl7.fhir.uv.ips: 1.1.0           # International Patient Summary
  ihe.iti.mhd: 4.2.2               # IHE Mobile Health Documents
```

**Parámetros de compilación:**

```yaml
parameters:
  apply-publisher: true             # Aplicar configuración del publisher
  apply-contact: true               # Incluir información de contacto
  show-inherited-invariants: false   # No mostrar restricciones heredadas
  excludettl: true                  # Excluir formato Turtle de salida
  excludexml: true                  # Excluir formato XML de salida
  excludemap: false                 # Incluir mapeos de transformación
  path-history: http://mspbs.gov.py/fhir/history
  path-liquid: /template_PY/        # Ruta a template personalizado
```

---

### 2. Configuración del IG Publisher - `ig.ini`

**Ubicación:** Raíz del proyecto

```ini
[IG]
template = #template_PY          # Template personalizado de Paraguay
ig = https://github.com/hl7-fhir/ig-registry/tree/master/FHIR/ImplementationGuides
publisher = https://github.com/HL7/fhir-ig-publisher/releases/latest/download/publisher.jar
```

---

### 3. Configuración del Template - `template_PY/config.json`

**Ubicación:** `template_PY/config.json`

```json
{
  "tool": "jekyll",
  "canonicalBase": "https://mspbs.gov.py/fhir",
  "source": {
    "input": "input/fsh",
    "output": "output",
    "mappings": true,
    "testing": true,
    "examples": true
  },
  "formats": {
    "json": true,
    "xml": false,
    "ttl": false,
    "xlsx": true
  },
  "scripts": {
    "onLoad": "scripts/onLoad.xslt",
    "onGenerate": "scripts/onGenerate-main.xslt",
    "processPages": "scripts/processPages.xslt"
  }
}
```

---

### 4. Configuración de Build Scripts

#### `_build.bat` / `_build.sh` - Variables de descarga

```batch
REM Variables configurables en scripts de build
set dlurl=https://github.com/HL7/fhir-ig-publisher/releases/latest/download/publisher.jar
set publisher_jar=publisher.jar
set input_cache_path=.\input-cache\
set skipPrompts=false
set upper_path=..\
set scriptdlroot=https://raw.githubusercontent.com/HL7/ig-publisher-scripts/main

REM Variables del compilador FHIR
set fhirversion=4.0.1
set input_folder=input
set output_folder=output
set java_opts=-Xmx4096M -Dfile.encoding=UTF-8
```

#### `_genonce.bat` / `_genonce.sh` - Variables de compilación única

```bash
publisher_jar="publisher.jar"
input_cache_path="./input-cache/"
JAVA_TOOL_OPTIONS="-Dfile.encoding=UTF-8"

# Modo online o offline con Terminology Server
txoption=""                    # Online (sin parámetro)
# txoption="-tx n/a"          # Offline (sin validación terminológica)
```

---

## 📖 Terminología Definida

### 1. CodeSystems Definidos

#### `CIE10CSES` - ICD-10 Codificación en Español

**Archivo:** `input/fsh/ICD10Core.fsh`

```fsh
CodeSystem: CIE10CSES
Id: CIE10CSES
Title: "CIE-10 Codificación"
Description: "ICD-10 Clasificación Internacional de Enfermedades, revisión 10"
* ^url = "http://hl7.org/fhir/sid/icd-10"
* ^valueSet = "https://mspbs.gov.py/fhir/ValueSet/CIE10VSES"
* ^caseSensitive = false
* ^hierarchyMeaning = #is-a
* ^compositional = false
* ^versionNeeded = false
* ^content = #complete
* ^count = 14400  # Aprox. Códigos disponibles
```

**Características:**
- Códigos estructurados jerárquicamente (3-5 caracteres)
- Formato: `A00-Z99` (capítulos) → Bloques → Categorías → Subcategorías
- Incluye nombres expandidos en español

**Ejemplo de códigos:**
```
A00        - Cólera
A00.0      - Cólera con depleción de agua y electrolitos
A00.1      - Cólera sin depleción de agua y electrolitos
I10        - Hipertensión esencial
I10.0      - Con crisis hipertensiva
```

#### `IdentificadoresPersonaCS` - Tipos de Identificadores

**Archivo:** `input/fsh/CS_VS.fsh`

**URL:** `https://mspbs.gov.py/fhir/CodeSystem/IdentificadoresPersonaCS`

```fsh
CodeSystem: IdentificadoresPersonaCS
Id: IdentificadoresPersonaCS
Title: "Identificadores de Persona"
Description: "Tipos de documentos de identificación para personas en Paraguay"
* #cedula           "Cédula de Identidad"
* #pasaporte        "Pasaporte"
* #ruc              "RUC - Registro Único del Contribuyente"
* #permiso_residencia "Permiso de Residencia"
* #registro_extranjero "Registro de Extranjero"
* #documento_temp   "Documento Temporal"
```

---

### 2. ValueSets Definidos

#### `CIE10VSES` - ValueSet CIE-10 Español

**Archivo:** `input/fsh/Cie10VS.fsh`

**URL:** `https://mspbs.gov.py/fhir/ValueSet/CIE10VSES`

```fsh
ValueSet: CIE10VSES
Id: CIE10VSES
Title: "CIE-10 Codificación de Diagnósticos"
Description: "ValueSet que incluye todos los códigos válidos de CIE-10"
* codes from system http://hl7.org/fhir/sid/icd-10
* ^expansion.contains.count = 14400
```

**Usos:** 
- Vinculación de diagnósticos en `ConditionPy`
- Referencia en `AlergiasPy` para tipos de reacciones
- Compatible con búsquedas por jerarquía

#### `IdentificadoresPersonaVS` - ValueSet Identificadores

**URL:** `https://mspbs.gov.py/fhir/ValueSet/IdentificadoresPersonaVS`

```fsh
ValueSet: IdentificadoresPersonaVS
Id: IdentificadoresPersonaVS
Title: "Identificadores de Persona - Valores Permitidos"
* codes from system IdentificadoresPersonaCS
```

#### `IdentificadoresProfesionalVS` - Identificadores de Profesionales

**URL:** `https://mspbs.gov.py/fhir/ValueSet/IdentificadoresProfesionalVS`

```fsh
ValueSet: IdentificadoresProfesionalVS
Id: IdentificadoresProfesionalVS
Title: "Identificadores de Profesionales de Salud"
Description: "Identifica profesionales sanitarios en Paraguay"
* codes from system IdentificadoresPersonaCS
* ^expansion.contains.count = 5
```

---

### 3. Alias de Referencias Canónicas

**Archivo:** `input/fsh/Alias.fsh`

Los siguientes alias se definen para acceso rápido a recursos:

#### CodeSystems
```fsh
Alias:  $CSIdentificadoresPersona = https://mspbs.gov.py/fhir/CodeSystem/IdentificadoresPersonaCS
Alias:  $CSProfesionales = https://mspbs.gov.py/fhir/CodeSystem/IdentificadoresProfesionalCS
Alias:  $SNOMED = http://snomed.info/sct
Alias:  $LOINC = http://loinc.org
Alias:  $ICD10 = http://hl7.org/fhir/sid/icd-10
```

#### ValueSets
```fsh
Alias:  $CIE10VS = https://mspbs.gov.py/fhir/ValueSet/CIE10VSES
Alias:  $PersonaIdentificadores = https://mspbs.gov.py/fhir/ValueSet/IdentificadoresPersonaVS
Alias:  $ProfesionalIdentificadores = https://mspbs.gov.py/fhir/ValueSet/IdentificadoresProfesionalVS
```

#### Perfiles / StructureDefinitions
```fsh
Alias:  $Patient = https://mspbs.gov.py/fhir/StructureDefinition/PacientePy
Alias:  $Practitioner = https://mspbs.gov.py/fhir/StructureDefinition/PractitionerPy
Alias:  $Organization = https://mspbs.gov.py/fhir/StructureDefinition/OrganizacionPy
Alias:  $Condition = https://mspbs.gov.py/fhir/StructureDefinition/ConditionPy
Alias:  $AllergyIntolerance = https://mspbs.gov.py/fhir/StructureDefinition/AlergiaPy
Alias:  $MedicationStatement = https://mspbs.gov.py/fhir/StructureDefinition/MedicationStatementPy
Alias:  $Composition = https://mspbs.gov.py/fhir/StructureDefinition/CompositionPy
Alias:  $Bundle = https://mspbs.gov.py/fhir/StructureDefinition/BundleDocPy
Alias:  $DocumentReference = https://mspbs.gov.py/fhir/StructureDefinition/DocumentReferencePy
Alias:  $Immunization = https://mspbs.gov.py/fhir/StructureDefinition/ImmunizationPy
```

#### Extensiones
```fsh
Alias:  $ext-birthPlace = http://hl7.org/fhir/StructureDefinition/birthPlace
Alias:  $ext-patient-citizenship = http://hl7.org/fhir/StructureDefinition/patient-citizenship
Alias:  $ext-person-sex-for-clinical-use = http://hl7.org/fhir/StructureDefinition/person-sex-for-clinical-use
```

---

## 🔧 Variables Configurables

### 1. Variables de Compilación SUSHI

| Variable | Ubicación | Tipo | Propósito |
|----------|-----------|------|----------|
| `id` | sushi-config.yaml | String | Identificador único del IG |
| `canonical` | sushi-config.yaml | URL | Base URL canónica |
| `version` | sushi-config.yaml | SemVer | Versión del IG |
| `fhirVersion` | sushi-config.yaml | SemVer | Versión FHIR base |
| `releaseLabel` | sushi-config.yaml | String | Etiqueta de release (ci-build, draft, release) |

### 2. Variables de Publicación (Publisher)

| Variable | Ubicación | Tipo | Propósito |
|----------|-----------|------|----------|
| `url` | sushi-config.yaml | URL | URL de publicación del IG |
| `name` | sushi-config.yaml | String | Nombre del IG |
| `title` | sushi-config.yaml | String | Título displayable |
| `description` | sushi-config.yaml | String | Descripción |
| `jurisdiction` | sushi-config.yaml | CodeableConcept | País/Jurisdicción |
| `contact.name` | sushi-config.yaml | String | Nombre del contacto |
| `contact.telecom.system` | sushi-config.yaml | String | Sistema telecom (phone, email, url, fax) |
| `contact.telecom.value` | sushi-config.yaml | String | Valor del contacto |

### 3. Variables de Path y Búsqueda (Terminology)

| Variable | Ubicación | Valor Ejemplo | Descripción |
|----------|-----------|---|---|
| `tx` | _genonce.sh | `-tx n/a` | Modo offline sin Terminology Server |
| `tx` | _genonce.sh | `` (vacío) | Modo online con tx.fhir.org |
| `path-history` | sushi-config.yaml | `http://mspbs.gov.py/fhir/history` | Historial de versiones |
| `path-liquid` | sushi-config.yaml | `/template_PY/` | Ruta a templates Liquid |
| `path-pages` | sushi-config.yaml | `input/pagecontent/` | Contenido de páginas |

### 4. Variables de Exclusión de Formatos

```yaml
# En sushi-config.yaml o template_PY/config.json
excludettl: true                    # No incluir Turtle (.ttl)
excludexml: false                   # Incluir XML (.xml)
excludemap: false                   # Incluir mapeos de transformación
excludejson: false                  # Incluir JSON (.json)
excludeexcel: false                 # Incluir hojas Excel (.xlsx)
```

### 5. Variables de Recursos Externos

#### En `_build.bat`:
```batch
REM URL de descarga del Publisher
set dlurl=https://github.com/HL7/fhir-ig-publisher/releases/latest/download/publisher.jar

REM URL de scripts comunes
set scriptdlroot=https://raw.githubusercontent.com/HL7/ig-publisher-scripts/main

REM Ruta local de caché
set input_cache_path=.\input-cache\

REM Saltar prompts interactivos
set skipPrompts=false
```

#### En `_genonce.sh`:
```bash
# Codificación de archivos
export JAVA_TOOL_OPTIONS="-Dfile.encoding=UTF-8"

# Memoria máxima de Java
export JAVA_MEMORY=4096M

# Ruta del publisher
publisher_jar="./input-cache/publisher.jar"

# Timeout de conexiones
connection_timeout=60000
```

---

### 6. Variables en Scripts Python

#### `Envios/cie10.py` - Descargador de CIE-10

```python
# URL base de ecieMaps (Ministerio Español de Sanidad)
BASE_URL = "https://eciemaps.mscbs.gob.es/ecieMaps/servlet/Cie10Arbol"

# Capítulos de CIE-10-ES (puede ajustarse)
capitulos = [f"{i:02d}" for i in range(1, 23)]  # 22 capítulos

# Parámetros personalizables
PARAMS = {
    "noMostrar": 0,           # Mostrar todos
    "tipo": 1,                # Tipo de búsqueda
    "codigo": "{codigo}"      # Placeholder
}

# Dependencias requeridas
# - requests
# - pandas
# - openpyxl

# Archivo de salida
output_file = "cie10_es_completo_con_subcategorias.xlsx"
```

#### `Envios/fhir_put_folder.py` - Subidor de Recursos

```python
# Servidor FHIR configurable
FHIR_SERVER = "http://localhost:8080/fhir"  # Cambiar según servidor

# Rutas de carpetas
resource_folder = "./recursos"
output_log = "./fhir_upload.log"

# Tipos de recursos a subir
resource_types = ["Patient", "Practitioner", "Organization", "Condition", "AllergyIntolerance"]

# Parámetros HTTP
timeout = 30
verify_ssl = False
```

---

### 7. Variables de Dependencias

**En sushi-config.yaml:**

```yaml
dependencies:
  # Dependencia: Internacional Patient Summary
  hl7.fhir.uv.ips: 
    uri: https://profiles.ihe.net/PCC/IPS/
    version: 1.1.0
    
  # Dependencia: IHE Mobile Health Documents 
  ihe.iti.mhd:
    uri: https://profiles.ihe.net/ITI/MHD/
    version: 4.2.2
```

**Versionamiento:**
- Formato SemVer: `major.minor.patch`
- Cambio de versión requiere recompilación completa
- Las dependencias se descargan automáticamente en compilación

---

## 👥 Perfiles FHIR

### 1. Perfiles Demográficos

| Perfil | Recurso | Archivo | URL Canónica | Propósito |
|--------|---------|---------|-------------|----------|
| `PacientePy` | Patient | PacientePy.fsh | https://mspbs.gov.py/fhir/StructureDefinition/PacientePy | Datos demográficos de pacientes |
| `PractitionerPy` | Practitioner | PractitionerPy.fsh | https://mspbs.gov.py/fhir/StructureDefinition/PractitionerPy | Datos de profesionales de salud |
| `OrganizacionPy` | Organization | OrganizacionPy.fsh | https://mspbs.gov.py/fhir/StructureDefinition/OrganizacionPy | Instituciones de salud |
| `PractitionerRolePy` | PractitionerRole | (generado) | https://mspbs.gov.py/fhir/StructureDefinition/PractitionerRolePy | Rol del profesional |

### 2. Perfiles Clínicos

| Perfil | Recurso | URL Canónica | Uso |
|--------|---------|-------------|-----|
| `ConditionPy` | Condition | https://mspbs.gov.py/fhir/StructureDefinition/ConditionPy | Diagnósticos (CIE-10) |
| `AlergiaPy` | AllergyIntolerance | https://mspbs.gov.py/fhir/StructureDefinition/AlergiaPy | Alergias - default |
| `AlergiaPySNOMED` | AllergyIntolerance | https://mspbs.gov.py/fhir/StructureDefinition/AlergiaPySNOMED | Alergias - SNOMED |
| `MedicationStatementPy` | MedicationStatement | https://mspbs.gov.py/fhir/StructureDefinition/MedicationStatementPy | Medicamentos administrados |
| `ImmunizationPy` | Immunization | https://mspbs.gov.py/fhir/StructureDefinition/ImmunizationPy | Inmunizaciones/Vacunas |
| `ObservationPy` | Observation | https://mspbs.gov.py/fhir/StructureDefinition/ObservationPy | Observaciones clínicas |

### 3. Perfiles de Documentos

| Perfil | Recurso | URL Canónica | Propósito |
|--------|---------|-------------|----------|
| `CompositionPy` | Composition | https://mspbs.gov.py/fhir/StructureDefinition/CompositionPy | Estructura de documento clínico |
| `BundleDocPy` | Bundle | https://mspbs.gov.py/fhir/StructureDefinition/BundleDocPy | Empaquetamiento de documentos |
| `BundleTransPy` | Bundle | https://mspbs.gov.py/fhir/StructureDefinition/BundleTransPy | Empaquetamiento de transacciones |
| `DocumentReferencePy` | DocumentReference | https://mspbs.gov.py/fhir/StructureDefinition/DocumentReferencePy | Referencias a documentos |
| `ListPy` | List | https://mspbs.gov.py/fhir/StructureDefinition/ListPy | Listas de recursos |

---

## 💡 Ejemplos de Uso

### 1. Referencia a Terminología en Perfiles

```fsh
// En un perfil, vincular a un ValueSet
* code from $CIE10VS (required)    // Vincula al ValueSet CIE-10

// Usar CodeSystem directo
* value[x] from IdentificadoresPersonaVS (required)

// Con binding de intensidad
* code from CIE10VSES (required)   // required = preferido y validado
* code from CIE10VSES (extensible) // extensible = preferido pero permite otros
* code from CIE10VSES (preferred)  // preferred = recomendado pero no obl.
```

### 2. Variables en Búsquedas Terminology Server

```fsh
// Expansión de ValueSet con parámetros
* ^expansion.contains.system = "http://hl7.org/fhir/sid/icd-10"
* ^expansion.contains.code = #I10        // Código específico
* ^expansion.contains.display = "Hypertension"

// Búsqueda con composición
* compose.include.system = "http://hl7.org/fhir/sid/icd-10"
* compose.include.concept[+].code = #A00
* compose.include.concept[+].code = #A01
```

### 3. Compilación con Variables Personalizadas

```bash
# Compilación online con Terminology Server
./genonce.sh -tx o

# Compilación offline sin validación terminológica
./genonce.sh -tx n/a

# Compilación con parámetro específico
java -jar publisher.jar -ig . -params.path-liquid /template_PY/

# Compilación con memoria personalizada
JAVA_TOOL_OPTIONS="-Xmx6144M" ./genonce.sh
```

### 4. Uso de Alias en Perfiles

```fsh
Profile: PacientePy
Parent: $Patient                  // Usa alias del perfil base
Id: PacientePy
Title: "Paciente Paraguay"

* identifier with $PersonaIdentificadores     // Usa alias de ValueSet
* name 1..1
* birthDate 1..1
* link referenceResource($Patient)            // Auto-referencia
```

---

## 📋 Checklist de Configuración

- [ ] Actualizar `id` y `canonical` según dominio oficial
- [ ] Verificar `fhirVersion` acorde a especificación
- [ ] Configurar `releaseLabel` (ci-build → draft → release)
- [ ] Asegurar versión `0.1` → mayor versión en releases
- [ ] Validar todas las referencias a `$alias` 
- [ ] Probar compilación con `-tx o` (online)
- [ ] Probar compilación con `-tx n/a` (offline)
- [ ] Revisar CHANGELOG con cambios de terminología
- [ ] Validar dependencias externas vigentes
- [ ] Documentar nuevos CodeSystems/ValueSets en `input/pagecontent/Terminologia.md`

---

## 🔗 Referencias Útiles

- **FHIR Oficial:** https://www.hl7.org/fhir/
- **SUSHI Docs:** https://fshschool.org/
- **CIE-10-ES:** https://eciemaps.mscbs.gob.es/
- **IPS:** https://www.hl7.org/fhir/uv/ips/
- **IHE MHD:** https://profiles.ihe.net/ITI/MHD/

---

## 📝 Notas y Historial

**Última revisión:** 10 de abril de 2026

**Cambios recientes:**
- Análisis exhaustivo de todo archivo de configuración
- Mapeo completo de 15 perfiles definidos
- Documentación de CIE-10 con ~14,400 códigos
- 3 ValueSets y 2 CodeSystems operativos

**Próximas consideraciones:**
- Expansión de CodeSystem de profesionales
- Integración con SNOMED-CT (opcional)
- Migración a FHIR 5.0 (futuro)

