## **Transacciones e Interoperabilidad**

Esta página documenta las operaciones RESTful y transacciones definidas para el intercambio seguro y estructurado de información clínica entre sistemas FHIR en Paraguay, basadas en el estándar IHE ITI Mobile Health Documents (MHD).

---

### **Introducción**

Las transacciones FHIR permiten que los sistemas de información en salud intercambien documentos clínicos, resúmenes de pacientes y otros artefactos de una manera estandarizada e interoperable. Estas operaciones se basan en:

- **IHE ITI MHD 4.2.2**: Framework de interoperabilidad móvil
- **FHIR R4**: Estándar de intercambio de datos de salud
- **RDA (Resumen Digital en Atención)**: Adaptación local del International Patient Summary

---

### **Transacciones Principales**

#### **1️⃣ Registrar Documento Clínico (MDH ITI-65)**

**Operación**: POST (Crear/Actualizar recurso)  
**Endpoint**: `POST <Base_Servidor>/`

**Descripción**:  
Envía un nuevo documento clínico (RDA) al repositorio central. El documento contiene la información clínica estructurada de un paciente en un punto específico de atención.

**Recursos Incluidos en la Transacción**:

| Recurso | Tipo | Obligatorio | Descripción |
|---------|------|-----------|------------|
| **Bundle** | Transaction | ✅ Sí | Contenedor de transacción con método POST |
| **Composition** | Resource | ✅ Sí | Estructura del documento clínico (RDA) |
| **Patient** | Resource | ✅ Sí | Datos demográficos del paciente |
| **Organization** | Resource | ✅ Sí | Institución de salud proveedora |
| **Practitioner** | Resource | ⚠️ Condicional | Si hay profesional responsable |
| **Condition** | Resource | ⚠️ Condicional | Diagnósticos del paciente |
| **MedicationStatement** | Resource | ⚠️ Condicional | Medicamentos activos |
| **AllergyIntolerance** | Resource | ⚠️ Condicional | Alergias conocidas |
| **Immunization** | Resource | ⚠️ Condicional | Antecedentes de vacunas |
| **DocumentReference** | Resource | ✅ Sí | Metadatos e índice del documento |
| **List** | Resource | ✅ Sí | Listados organizados de recursos |

**Ejemplo de solicitud** (pseudo-código):
```
POST https://fhir.mspbs.gov.py/fhir/
Content-Type: application/fhir+json

{
  "resourceType": "Bundle",
  "type": "transaction",
  "entry": [
    { "resource": { "resourceType": "Patient", ... }, "request": { "method": "POST", "url": "Patient" } },
    { "resource": { "resourceType": "Composition", ... }, "request": { "method": "POST", "url": "Composition" } },
    { "resource": { "resourceType": "DocumentReference", ... }, "request": { "method": "POST", "url": "DocumentReference" } },
    ...
  ]
}
```

**Respuesta esperada**:
- **HTTP 200** o **201**: Transacción procesada exitosamente
- **HTTP 400**: Error en validación de datos
- **HTTP 401**: Autenticación requerida

---

#### **2️⃣ Buscar Documentos de un Paciente (MDH ITI-67)**

**Operación**: GET (Consultar recursos)  
**Endpoint**: `GET <Base_Servidor>/DocumentReference?patient.identifier=<valor>`

**Descripción**:  
Consulta los metadatos de todos los documentos clínicos almacenados para un paciente específico. Retorna una lista de referencias a documentos sin el contenido completo.

**Parámetros de búsqueda soportados**:

| Parámetro | Tipo | Ejemplo | Descripción |
|-----------|------|---------|------------|
| `patient.identifier` | Token | `?patient.identifier=98765` | ID nacional del paciente (cédula) |
| `date` | Date | `?date=ge2024-01-01` | Documentos desde fecha específica |
| `type` | Code | `?type=RDA` | Tipo de documento (RDA, receta, etc.) |
| `status` | Code | `?status=current` | Estado del documento (current, superseded) |

**Ejemplo de solicitud**:
```
GET https://fhir.mspbs.gov.py/fhir/DocumentReference?patient.identifier=98765&date=ge2024-01-01
```

**Respuesta esperada** (Bundle de tipo searchset):
```json
{
  "resourceType": "Bundle",
  "type": "searchset",
  "total": 3,
  "entry": [
    {
      "resource": {
        "resourceType": "DocumentReference",
        "id": "doc-001",
        "status": "current",
        "date": "2024-03-15T10:30:00Z",
        ...
      }
    },
    ...
  ]
}
```

---

#### **3️⃣ Recuperar Documento Completo (MDH ITI-68)**

**Operación**: GET (Recuperar recurso específico)  
**Endpoint**: `GET <Base_Servidor>/Bundle/<DocumentID>`

**Descripción**:  
Obtiene el documento clínico completo (Bundle) que contiene toda la información estructurada: demográficos, diagnósticos, medicamentos, alergias, etc.

**Ejemplo de solicitud**:
```
GET https://fhir.mspbs.gov.py/fhir/Bundle/bundle-doc-001
```

**Respuesta esperada**:
```json
{
  "resourceType": "Bundle",
  "type": "document",
  "id": "bundle-doc-001",
  "entry": [
    { "resource": { "resourceType": "Composition", ... } },
    { "resource": { "resourceType": "Patient", ... } },
    { "resource": { "resourceType": "Condition", ... } },
    ...
  ]
}
```

---

### **Consideraciones de Seguridad y Autenticación**

1. **Autenticación**: Todas las operaciones deben autenticarse con Bearer Token (OAuth 2.0) o credenciales básicas
2. **Autorización**: Solo profesionales autorizados pueden enviar/consultar documentos de pacientes específicos
3. **Encriptación**: HTTPS es obligatorio para todos los endpoints
4. **Auditoría**: Se registra quién accese, cuándo y qué recursos consultó

---

### **Ejemplos de Uso Práctico**

Consultar la carpeta [Envios/ejemplos/](../../Envios/ejemplos/) para ver implementaciones completas en JSON de:
- `trancCompleta.jsonc` - Transacción completa de documento RDA
- `trancCompleta2.jsonc` - Variante con múltiples secciones clínicas
- `Organization.jsonc` - Ejemplo de organización proveedora

---

### **Casos de Uso Comunes**

#### **Caso 1: Envío de Resumen de Atención al Egresar**
- Profesional clínico finaliza atención y genera RDA
- Sistema envía POST (ITI-65) con todos los datos
- Servidor FHIR almacena y retorna confirmación

#### **Caso 2: Consulta de Historial de Documentos**
- Médico de otro nivel de atención busca documentos previos
- Realiza GET (ITI-67) con ID del paciente
- Obtiene listado de documentos disponibles
- Selecciona un documento y realiza GET (ITI-68) para detalles

#### **Caso 3: Emergencia y Acceso a Información Crítica**
- Paciente llega a urgencias sin información
- Sistema de urgencias consulta GET (ITI-67)
- Obtiene últimos documentos del paciente
- Accede a medicamentos activos, alergias, diagnósticos previos

---
