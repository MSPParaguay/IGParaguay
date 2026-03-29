## **Requisitos de Conformance**

Esta página define los requisitos y niveles de soporte que los sistemas deben cumplir para implementar esta Guía de Implementación FHIR Paraguay.

---

### **Introducción**

La conformance describe qué elementos FHIR son **obligatorios (MUST)**, **recomendados (SHOULD)** u **opcionales (MAY)** según el rol del sistema y el caso de uso. Los requisitos se categorizan en:

- **Nivel 1 - Productor RDA**: Sistemas que generan y envían documentos clínicos
- **Nivel 2 - Consumidor RDA**: Sistemas que buscan, recuperan y utilizan documentos  
- **Nivel 3 - Intermediario/Repositorio**: Servidores FHIR que almacenan y gestionan documentos

---

### **Matriz de Perfiles por Nivel**

#### **Perfiles Demográficos (Obligatorios en Todos los Niveles)**

| Perfil | L1 Productor | L2 Consumidor | L3 Repositorio | Mínimo Requerido |
|--------|:---:|:---:|:---:|---|
| **PacientePy** | MUST** | MUST | MUST | ID + Nombres + Sexo + Fecha Nacimiento |
| **PractitionerPy** | MUST | SHOULD | MUST | Nombres + Identificador |
| **OrganizacionPy** | MUST | SHOULD | MUST | Nombre + Identificador |

#### **Perfiles Clínicos (Condicionales)**

| Perfil | L1 Productor | L2 Consumidor | L3 Repositorio | Cuándo es Obligatorio |
|--------|:---:|:---:|:---:|---|
| **ConditionPy** | MUST* | MUST | MUST | Si hay diagnóstico documentado |
| **MedicationStatementPy** | MUST* | MUST | MUST | Si paciente tiene medicamentos activos |
| **AlergiaPy** | MUST* | MUST | MUST | Si se conoce alergia confirmada |
| **ImmunizationPy** | SHOULD | SHOULD | SHOULD | Información de vacunación disponible |

#### **Perfiles de Documentos (Obligatorios para RDA)**

| Perfil | L1 Productor | L2 Consumidor | L3 Repositorio | Obligatorio para |
|--------|:---:|:---:|:---:|---|
| **CompositionPy** | MUST | MUST | MUST | Estructura de documento RDA |
| **BundleDocPy** | MUST | MUST | MUST | Empaquetamiento del documento |
| **DocumentReferencePy** | MUST | MUST | MUST | Metadatos e indexación |
| **ListPy** | MUST | MUST | MUST | Organización de referencias |
| **BundleTransaccPy** | MUST | SHOULD | MUST | Transacciones POST |

---

### **Requisitos por Caso de Uso**

#### **Caso 1: Registro de Atención al Egresar (Productor)**

**Operación**: POST Bundle Transaction (ITI-65)

**Requisitos Obligatorios (MUST)**:
- ✅ Crear o enviar Patient completo (PacientePy)
- ✅ Incluir Composition con todas las secciones documentadas
- ✅ Incluir al menos 1 Condition si hay diagnóstico
- ✅ Incluir MedicationStatement si hay medicamentos activos
- ✅ Incluir Practitioner como author
- ✅ Incluir Organization como custodian
- ✅ Enviar DocumentReference con metadatos

**Requisitos Recomendados (SHOULD)**:
- ⚠️ Incluir AllergyIntolerance si se conocen alergias
- ⚠️ Incluir Immunization si hay antecedentes de vacunación
- ⚠️ Usar códigos SNOMED CT o CIE-10 para diagnósticos

**Requisitos Opcionales (MAY)**:
- ⚪ Incluir attachments adicionales (PDF, imágenes)
- ⚪ Agregar extensions nacionales personalizadas

---

#### **Caso 2: Consulta de Historial de Documentos (Consumidor)**

**Operación**: GET DocumentReference Search (ITI-67)

**Requisitos Obligatorios (MUST)**:
- ✅ Soportar búsqueda por `patient.identifier`
- ✅ Soportar filtro por `status=current`
- ✅ Retornar Bundle de tipo searchset
- ✅ Incluir campo `date` en respuesta

**Requisitos Recomendados (SHOULD)**:
- ⚠️ Soportar búsqueda por rango de fechas (`date=ge...`)
- ⚠️ Soportar paginación (_count, _offset)
- ⚠️ Retornar total de matches

**Requisitos Opcionales (MAY)**:
- ⚪ Soportar búsqueda por `type` (¿qué tipo de documento?)
- ⚪ Retornar score de relevancia

---

#### **Caso 3: Recuperación de Documento Completo (Consumidor)**

**Operación**: GET Bundle Document (ITI-68)

**Requisitos Obligatorios (MUST)**:
- ✅ Retornar Bundle de tipo document
- ✅ Incluir Composition raíz
- ✅ Incluir todos los recursos referenciados
- ✅ Validar acceso basado en Role Based Access Control (RBAC)

**Requisitos Recomendados (SHOULD)**:
- ⚠️ Mantener relaciones entre recursos
- ⚠️ Retornar sin información sensible si no está autorizado

---

### **Niveles de Elemento (mustSupport)**

Los elementos con `mustSupport` (MS) deben ser **explícitamente validados** por los sistemas implementadores. Si un sistema no puede procesar un elemento MS, debe:

1. Registrar un error de validación
2. Informar al usuario de la incapacidad técnica
3. NO ignorar silenciosamente el elemento

#### **Elementos MS por Perfil**

**PacientePy**:
- ✅ `identifier[0]` (cédula nacional)
- ✅ `name[0]` (apellido y nombre)
- ✅ `gender`
- ✅ `birthDate`

**ConditionPy**:
- ✅ `code` (CIE-10)
- ✅ `subject` (referencia a Patient)
- ✅ `clinicalStatus` o `verificationStatus`

**MedicationStatementPy**:
- ✅ `subject` (referencia a Patient)
- ✅ `medicationCodeableConcept.text` (nombre del medicamento)
- ✅ `status`
- ✅ `dosage.text` (instrucciones de dosis)

**CompositionPy**:
- ✅ `status` (obligatoriamente #final)
- ✅ `type` (tipo de documento)
- ✅ `subject` (referencia a Patient)
- ✅ `author` (referencia a Practitioner)
- ✅ `custodian` (referencia a Organization)
- ✅ `date`
- ✅ `title`
- ✅ `section` (al menos 1)

---

### **Validación y Testing**

#### **Herramientas Recomendadas**

- **FHIR Validator** (HL7): Validar conformidad con perfiles
  ```bash
  java -jar validator_cli.jar -version 4.0 resource.json -ig hl7.fhir.py.CorePY
  ```

- **Postman/REST Client**: Probar transacciones REST
  
- **HAPI FHIR**: Servidor de validación local

#### **Casos de Prueba Mínimos**

| Test ID | Descripción | Entrada | Salida Esperada |
|---------|---|---|---|
| TC-001 | Validar Composition con secciones | CompositionEjemploPy | Valid (sin errores) |
| TC-002 | Validar Bundle Transaction | BundleDocumentEjemploParaguay | Valid |
| TC-003 | Rechazar Composition sin status | Composition sin status | Error - MUST |
| TC-004 | Rechazar Patient sin identifier | Patient vacío | Error - MUST |
| TC-005 | Aceptar Condition sin Immunization | Bundle sin Immunization | Valid (opcional) |

---

### **Tablas Rápidas de Referencia**

#### **Resumen de Cardinalidades Críticas**

| Elemento | Min | Max | Ejemplos Válidos |
|----------|-----|-----|---|
| `Patient.identifier` | 1 | ∞ | Cédula, Pasaporte, etc. |
| `Patient.name` | 1 | ∞ | Nombre oficial + apodos |
| `Condition.code` | 1 | 1 | CIE-10 code |
| `Composition.status` | 1 | 1 | #final (siempre) |
| `Bundle.type` | 1 | 1 | #document o #transaction |
| `Composition.section` | 1 | ∞ | Diagnósticos, Medicamentos, etc. |

#### **Identificadores Nacionales Soportados**

| Tipo | ValueSet | Ejemplo |
|------|----------|---------|
| Cédula de Identidad | `IdentificadoresPersonaVS` | 98765 |
| Licencia de Conducir | `IdentificadoresPersonaVS` | LIC-123456 |
| Pasaporte | `IdentificadoresPersonaVS` | PA-098765 |
| Profesional Sanitario | `IdentificadoresProfesionalVS` | 5555555 |

---

### **Excepciones y Casos Especiales**

#### **Pacientes sin Identificador Nacional**

En emergencias, se permite crear Patient con `birthDate` + `name` sin `identifier`. 

**Requisito posterior**: Completar `identifier` en la próxima transacción.

#### **Medicamentos sin Código Normalizado**

Si no hay CIE-10/ATC disponible, usar `medicationCodeableConcept.text` con nome del medicamento.

**Recomendación**: Codificar a posteriori con profesional encargado.

---

### **Contacto y Consultas**

Para aclaraciones sobre conformance:
- **Correo**: interoperabilidad@mspbs.gov.py
- **URL**: https://mspbs.gov.py/fhir

---
