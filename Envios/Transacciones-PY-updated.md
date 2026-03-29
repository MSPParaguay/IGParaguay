## **Transacciones e Interoperabilidad**

Esta página documenta las operaciones RESTful y transacciones definidas para el intercambio seguro y estructurado de información clínica entre sistemas FHIR en Paraguay, basadas en el estándar IHE ITI Mobile Health Documents (MHD) v4.2.2.

---

### **Introducción**

Las transacciones FHIR permiten que los sistemas de información en salud intercambien documentos clínicos, resúmenes de pacientes y otros artefactos de una manera estandarizada e interoperable. Estas operaciones se basan en:

- **IHE ITI MHD 4.2.2**: Framework de interoperabilidad móvil para documentos
- **FHIR R4**: Estándar de intercambio de datos de salud
- **RDA (Resumen Digital en Atención)**: Adaptación local del International Patient Summary (IPS)

Todas las transacciones requieren:
- **Autenticación**: OAuth 2.0 Bearer Token o HTTP Basic Auth
- **HTTPS**: Encriptación TLS obligatoria
- **Validación**: Los datos deben cumplir con los perfiles definidos en esta Guía

---

### **Transacciones Principales**

#### **1️⃣ Registrar Documento Clínico (MHD ITI-65)**

**Operación**: POST (Crear/Actualizar documento)  
**Estándar**: IHE ITI-65 (Provide)  
**Endpoint**: `POST <BaseURL>/`  
**Propósito**: Enviar un nuevo RDA al repositorio de documentos central

**Descripción**:  
Un sistema emisor (ej: hospital, clínica) que ha completado una atención clínica genera un Resumen Digital en Atención y lo envía al repositorio nacional mediante una transacción FHIR Bundle de tipo "transaction".

**Estructura del Bundle**:

```
POST https://fhir.mspbs.gov.py/fhir/
Content-Type: application/fhir+json
Authorization: Bearer <token>

{
  "resourceType": "Bundle",
  "type": "transaction",
  "entry": [
    {
      "resource": { "resourceType": "Patient", ... },
      "request": { "method": "POST", "url": "Patient" }
    },
    {
      "resource": { "resourceType": "Composition", ... },
      "request": { "method": "POST", "url": "Composition" }
    },
    {
      "resource": { "resourceType": "Condition", ... },
      "request": { "method": "POST", "url": "Condition" }
    },
    ...
  ]
}
```

**Recursos Incluidos en la Transacción**:

| Recurso | Perfil Usado | Obligatorio | Cardinalidad | Descripción |
|---------|------|:---:|---|---|
| **Patient** | PacientePy | ✅ Sí | 1..1 | Datos demográficos del paciente |
| **Composition** | CompositionPy | ✅ Sí | 1..1 | Estructura del documento RDA |
| **Bundle (Document)** | BundleDocPy | ✅ Sí | 1..1 | Contenedor del documento completo |
| **DocumentReference** | DocumentReferencePy | ✅ Sí | 1..1 | Metadatos e índice del documento |
| **List** | ListPy | ✅ Sí | 1..1 | Lista de referencias a recursos |
| **Organization** | OrganizacionPy | ✅ Sí | 1..1 | Institución de salud proveedora |
| **Practitioner** | PractitionerPy | ✅ Sí | 1..1 | Profesional responsable del documento |
| **Condition** | ConditionPy | ⚠️ Condicional | 0..* | Diagnósticos (obligatorio si existen) |
| **MedicationStatement** | MedicationStatementPy | ⚠️ Condicional | 0..* | Medicamentos activos (obligatorio si existen) |
| **AllergyIntolerance** | AlergiaPy | ⚠️ Condicional | 0..* | Alergias (obligatorio si se conocen) |
| **Immunization** | ImmunizationPy | ⚠️ Recomendado | 0..* | Antecedentes de vacunación |

**Atributos Críticos**:
- `Bundle.type = "transaction"` (obligatorio)
- `Composition.status = "final"` (valor fijo)
- `DocumentReference.status = "current"` (valor fijo)
- Timestamps en formato ISO 8601 (YYYY-MM-DDTHH:mm:ssZ)

**Respuesta Esperada**:
```json
{
  "resourceType": "Bundle",
  "type": "transaction-response",
  "entry": [
    {
      "response": {
        "status": "201 Created",
        "location": "Patient/patient-001/_history/1",
        "etag": "W/\"1\""
      }
    },
    ...
  ]
}
```

**Códigos de Respuesta**:
| HTTP | Significado | Acción |
|------|---|---|
| **201** | Creado exitosamente | Documento almacenado, proceder |
| **200** | Actualizado | Documento existente fue reemplazado |
| **400** | Solicitud inválida | Error en validación de datos (revisar esquema) |
| **401** | No autenticado | Token faltante o expirado |
| **403** | Prohibido | Credenciales sin permisos |
| **422** | Entidad no procesable | Datos violan reglas de negocio |
| **500** | Error servidor | Retentar después |

---

#### **2️⃣ Buscar Documentos de un Paciente (MHD ITI-67)**

**Operación**: GET (Search)  
**Estándar**: IHE ITI-67 (Find)  
**Endpoint**: `GET <BaseURL>/DocumentReference?[parámetros]`  
**Propósito**: Localizar documentos clínicos de un paciente específico sin descargar contenido

**Descripción**:  
Un sistema consumidor busca todos los documentos disponibles de un paciente para luego seleccionar cuál descargar. Retorna metadatos sin el contenido completo.

**Parámetros de Búsqueda Soportados**:

```
GET https://fhir.mspbs.gov.py/fhir/DocumentReference?patient.identifier=98765&date=ge2024-01-01&_count=10
```

| Parámetro | Tipo | Ejemplo | Obligatorio | Descripción |
|-----------|------|---------|:---:|---|
| `patient.identifier` | Token | `98765` | ✅ Sí | ID nacional del paciente (cédula) |
| `date` | Date | `ge2024-01-01` | ⚠️ Recomendado | Rango de fechas (ge=mayor o igual, le=menor o igual) |
| `status` | Code | `current` | ⚠️ Recomendado | Estado (current, superseded, entered-in-error) |
| `type` | Code | `34105-7` | ⚪ Opcional | Tipo de documento (código LOINC) |
| `_count` | Integer | `20` | ⚪ Opcional | Número de resultados (default: 10) |
| `_offset` | Integer | `0` | ⚪ Opcional | Paginación (para grandes conjuntos) |

**Respuesta Esperada** (Bundle de tipo searchset):

```json
{
  "resourceType": "Bundle",
  "type": "searchset",
  "total": 3,
  "link": [
    {
      "relation": "self",
      "url": "https://fhir.mspbs.gov.py/fhir/DocumentReference?patient.identifier=98765"
    }
  ],
  "entry": [
    {
      "fullUrl": "https://fhir.mspbs.gov.py/fhir/DocumentReference/doc-001",
      "resource": {
        "resourceType": "DocumentReference",
        "id": "doc-001",
        "status": "current",
        "type": {
          "coding": [
            {
              "system": "http://loinc.org",
              "code": "34105-7",
              "display": "Resumen de Clínica"
            }
          ]
        },
        "date": "2024-03-15T10:30:00Z",
        "subject": { "reference": "Patient/patient-001" },
        "content": [
          {
            "attachment": {
              "url": "Bundle/bundle-doc-001",
              "contentType": "application/fhir+json"
            }
          }
        ]
      }
    },
    ...
  ]
}
```

**Campos Clave en Respuesta**:
- `total`: Número total de documentos encontrados
- `entry[].resource.id`: ID del DocumentReference (guardar para ITI-68)
- `entry[].resource.content[0].attachment.url`: Dónde descargar el bundle
- `entry[].resource.date`: Fecha del documento

---

#### **3️⃣ Recuperar Documento Completo (MHD ITI-68)**

**Operación**: GET (Read/Retrieve)  
**Estándar**: IHE ITI-68 (Retrieve)  
**Endpoint**: `GET <BaseURL>/Bundle/<BundleID>` o `<BaseURL>/DocumentReference/<DocRefID>/$document`  
**Propósito**: Descargar el documento RDA completo con toda su información estructurada

**Descripción**:  
Después de encontrar un documento en ITI-67, se descarga el Bundle completo que contiene: Composition + Patient + Conditions + Medications + Allergies + Practitioner + Organization.

**Solicitud**:

```
GET https://fhir.mspbs.gov.py/fhir/Bundle/bundle-doc-001
Accept: application/fhir+json
Authorization: Bearer <token>
```

O usando operation $document:

```
GET https://fhir.mspbs.gov.py/fhir/DocumentReference/doc-001/$document
Accept: application/fhir+json
```

**Respuesta Esperada** (Bundle de tipo document):

```json
{
  "resourceType": "Bundle",
  "type": "document",
  "id": "bundle-doc-001",
  "timestamp": "2024-03-15T10:30:00Z",
  "entry": [
    {
      "fullUrl": "urn:uuid:composition-001",
      "resource": {
        "resourceType": "Composition",
        "status": "final",
        "type": { "coding": [ { "system": "http://loinc.org", "code": "11450-4" } ] },
        "subject": { "reference": "urn:uuid:patient-001" },
        "author": [ { "reference": "urn:uuid:practitioner-001" } ],
        "custodian": { "reference": "urn:uuid:organization-001" },
        "section": [
          {
            "code": { "coding": [ { "system": "http://loinc.org", "code": "11450-4" } ] },
            "title": "Diagnósticos",
            "entry": [ { "reference": "urn:uuid:condition-001" } ]
          },
          ...
        ]
      }
    },
    { "resource": { "resourceType": "Patient", ... } },
    { "resource": { "resourceType": "Condition", ... } },
    { "resource": { "resourceType": "MedicationStatement", ... } },
    { "resource": { "resourceType": "AllergyIntolerance", ... } },
    { "resource": { "resourceType": "Practitioner", ... } },
    { "resource": { "resourceType": "Organization", ... } }
  ]
}
```

**Validaciones al Recibir**:
- ✅ Todos los recursos están presentes
- ✅ Las referencias internas usan `urn:uuid` o referencias relativas
- ✅ Composition.status = "final"
- ✅ Secciones solo contienen tipos de recursos permitidos

---

### **Seguridad y Autorización**

#### **1. Autenticación**

Todos los endpoints requieren **Bearer Token OAuth 2.0**:

```
Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
```

#### **2. Autorización (RBAC)**

| Rol | ITI-65 (POST) | ITI-67 (GET) | ITI-68 (GET Documento) |
|-----|:---:|:---:|:---:|
| **Productor** (Hospital) | ✅ Enviar propios documentos | ✅ Leer todos | ✅ Leer documentos propios |
| **Consumidor** (EPS) | ❌ No | ✅ Leer autorizados | ✅ Si está autorizado |
| **Administrador** | ✅ Todas | ✅ Todas | ✅ Todas |
| **Paciente** | ❌ No | ✅ Sus propios docs | ✅ Sus propios docs |

#### **3. Encriptación**

- **HTTPS 1.2+**: Obligatorio para todos los endpoints
- **Certificados**: Debe ser válido y emitido por CA reconocida
- **PHI en tránsito**: Encriptado extremo a extremo

#### **4. Auditoría**

El servidor FHIR registra:
- Quién accedió (`token.sub`)
- Qué fecha y hora
- Qué recurso/documento (`patient.id`, `resource.id`)
- Operación realizada (POST, GET)
- Resultado (exitoso, fallido)

---

### **Manejo de Errores**

#### **Errores Comunes y Soluciones**

| Error | Causa | Solución |
|-------|-------|----------|
| `401 Unauthorized` | Token faltante o expirado | Renovar token en endpoint `/oauth2/token` |
| `403 Forbidden` | Sin permisos para recurso | Solicitar acceso a administrador |
| `422 Unprocessable Entity` | Datos no conformes con perfil | Validar con FHIR Validator |
| `400 Bad Request` | Parámetro de búsqueda inválido | Revisar formato (ej: date=ge**2024-01-01**) |
| `500 Server Error` | Error interno | Retentar en 30 segundos |

#### **Validación Local Recomendada**

Antes de enviar a producción, validar localmente:

```bash
# Usando FHIR Validator
java -jar validator_cli.jar \
  -version 4.0 \
  -ig hl7.fhir.py.CorePY \
  bundle-document.json
```

---

### **Casos de Uso Prácticos**

#### **Escenario 1: Egresos Hospitalarios**

1. **Situación**: Paciente se da de alta de Hospital General Coronel Oviedo
2. **Acción**: Sistema hospitalario genera RDA con:
   - Composición de egreso
   - Diagnósticos principales (CIE-10)
   - Medicamentos prescritos (ATC)
   - Alergias confirmadas
3. **Operación**: POST (ITI-65) → Envía a repositorio nacional
4. **Resultado**: Sistema deregistra confirmación con ID de documento

#### **Escenario 2: Referencia a Especialista**

1. **Situación**: Centro de Salud Primario envía paciente a Hospital
2. **Acción**: Médico de primaria busca documentos previos
3. **Operación**: GET (ITI-67) con `patient.identifier=98765`
4. **Resultado**: Obtiene lista de 5 documentos previos
5. **Acción**: Selecciona RDA más reciente (2024-03-01)
6. **Operación**: GET (ITI-68) → Descarga bundle completo
7. **Resultado**: Especialista revisa diagnósticos, medicamentos, alergias
8. **Acción**: Retorna informe nuevo → Crea nuevo RDA → POST (ITI-65)

#### **Escenario 3: Emergencia y Acceso Crítico**

1. **Situación**: Paciente llega a urgencias inconsciente, sin antecedentes
2. **Acción**: Personal de urgencias escanea cédula de identidad
3. **Operación**: GET (ITI-67) → Busca `patient.identifier`
4. **Resultado**: Encuentra 2 documentos recientes
5. **Acción**: Descarga ITI-68 de documento más reciente
6. **Resultado**: Ve alergias a "Penicilina" → Evita prescribir
7. **Resultado**: Ve medicamentos activos (Warfarina) → Ajusta tratamiento

---

### **Ejemplos Completos**

#### **Ejemplo 1: Transacción POST Completa (ITI-65)**

Ver archivo: [Envios/ejemplos/trancCompleta.jsonc](../../Envios/ejemplos/trancCompleta.jsonc)

Este archivo contiene un Bundle de transacción completo incluyendo:
- Patient: Datos demográficos
- Composition: Estructura de documento
- Condition: Diagnóstico de hipertensión
- MedicationStatement: 2 medicamentos
- AllergyIntolerance: Alergia a penicilina
- Practitioner: Médico responsable
- Organization: Hospital que emite
- DocumentReference: Metadatos
- List: Referencias organizadas

#### **Ejemplo 2: Búsqueda y Recuperación (ITI-67 + ITI-68)**

```bash
# Paso 1: Buscar documentos del paciente 98765
curl -X GET "https://fhir.mspbs.gov.py/fhir/DocumentReference?patient.identifier=98765" \
  -H "Authorization: Bearer TOKEN" \
  -H "Accept: application/fhir+json"

# Respuesta contiene doc-id: "doc-2024-03-15-001"

# Paso 2: Descargar documento completo
curl -X GET "https://fhir.mspbs.gov.py/fhir/Bundle/bundle-2024-03-15-001" \
  -H "Authorization: Bearer TOKEN" \
  -H "Accept: application/fhir+json"

# Respuesta: Bundle de tipo document con todos los recursos
```

---

### **Referencias y Estándares**

- **IHE ITI MHD v4.2.2**: http://ihe.net/uploadedFiles/Documents/ITI/IHE_ITI_Suppl_MHD.pdf
- **FHIR R4 Document**: https://www.hl7.org/fhir/documents.html
- **FHIR R4 Search**: https://www.hl7.org/fhir/search.html
- **ISO 27269:2021 (IPS)**: International Patient Summary standard

---
