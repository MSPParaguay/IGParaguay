---
name: generador-ejemplos-fsh
description: "Use when: necesitas generar ejemplos FSH (FHIR Shorthand) válidos para cada uno de los perfiles de la Guía de Implementación FHIR Paraguay. Genera instancias completas que cumplen con las restricciones de cada perfil."
---

# Generador de Ejemplos FSH - IPS Paraguay

## Descripción

Esta skill automatiza la creación de instancias FSH válidas para todos los perfiles definidos en la Guía de Implementación FHIR de Paraguay. Genera ejemplos intermedios (con campos comunes y opcionales) que sirven como:

- Ejemplos de funcionamiento en documentación
- Casos de prueba para validación
- Plantillas para desarrolladores
- Recursos que cumplen especificaciones

## Perfiles Soportados

1. **PacientePy** - Identificación y datos demográficos del paciente
2. **PractitionerPy** - Información de profesionales sanitarios
3. **OrganizacionPy** - Organizaciones y entidades de salud
4. **ConditionPy** - Condiciones y diagnósticos (CIE-10)
5. **MedicationStatementPy** - Declaraciones de medicamentos
6. **AlergiaPy** - Alergias e intolerancias a medicamentos
7. **CompositionPy** - Documentos clínicos
8. **BundleDocPy** - Bundles para documentos clínicos
9. **DocumentReferencePy** - Referencias a documentos
10. **ListPy** - Listas clínicas
11. **BundleTransaccPy** - Bundles para transacciones

## Instrucciones de Uso

### Solicitud básica
```
/generador-ejemplos-fsh
Genera ejemplos para: PacientePy, PractitionerPy
```

### Con parámetros
```
/generador-ejemplos-fsh
Perfil: ConditionPy
Contexto: paciente diabético
Idioma: español
```

## Reglas de Generación de Ejemplos

### 1. Estructura General (Sintaxis FSH)

Cada instancia debe seguir esta estructura:

```fsh
Instance: [NombreInstancia]
InstanceOf: [NombrePerfil]
Usage: #example
Description: "[Descripción clara en español]"

* [elemento] = [valor]
* [elemento].coding.system = "[sistema]"
* [elemento].coding.code = #[código]
* [elemento].coding.display = "[display]"
```

### 2. PacientePy

**Campos obligatorios:**
- `identifier` (debe incluir cédula con sistema de identificación)
- `identifier.type.coding` (usar value set IdentificadoresPersonaVS)
- `identifier.value` (número de cédula)
- `name` (nombres y apellidos)
- `name.family` (apellidos, obligatorio)
- `name.given` (nombres, obligatorio)
- `gender` (male | female | other | unknown)
- `birthDate` (formato YYYY-MM-DD)

**Ejemplo válido:**
```fsh
Instance: PacienteDiabeticoEjemplo
InstanceOf: PacientePy
Usage: #example
Description: "Paciente paraguayo con diabetes tipo 2"

* identifier[0].type.coding.system = "http://terminology.hl7.org/CodeSystem/v2-0203"
* identifier[0].type.coding.code = #DNI
* identifier[0].value = "4123456"

* name.family = "González"
* name.given = "María"

* gender = #female
* birthDate = "1975-03-15"

* contact.telecom.system = #email
* contact.telecom.value = "maria.gonzalez@example.com"
```

### 3. PractitionerPy

**Campos obligatorios:**
- `identifier` (cédula profesional)
- `identifier.type.coding` (usar IdentificadoresProfesionalVS)
- `identifier.value` (número de cédula)
- `name` (nombres y apellidos)
- `name.family` (obligatorio)
- `name.given` (obligatorio)

**Campos opcionales recomendados:**
- `telecom` (contacto)
- `address` (domicilio)
- `qualification` (especialidades)

**Ejemplo válido:**
```fsh
Instance: MedicoCardiologoEjemplo
InstanceOf: PractitionerPy
Usage: #example
Description: "Médico cardiólogo paraguayo"

* identifier[0].type.coding.system = "$CSIdentificadoresProfesional"
* identifier[0].type.coding.code = #01
* identifier[0].type.coding.display = "Cédula de Identidad"
* identifier[0].value = "1234567"

* name.family = "Méndez"
* name.given = "Carlos"

* telecom[0].system = #phone
* telecom[0].value = "+595981234567"

* address.text = "Asunción, Paraguay"
* address.city = "Asunción"
* address.country = "PY"
```

### 4. OrganizacionPy

**Campos obligatorios:**
- `identifier` (código institucional)
- `identifier.type` (según tipo de organización)
- `name` (nombre de la organización)

**Campos opcionales recomendados:**
- `telecom` (contacto)
- `address` (dirección)
- `type` (tipo de organización)

**Ejemplo válido:**
```fsh
Instance: HospitalPublicoEjemplo
InstanceOf: OrganizacionPy
Usage: #example
Description: "Hospital público paraguayo de referencia"

* identifier[0].type.coding.system = "http://terminology.hl7.org/CodeSystem/v2-0203"
* identifier[0].type.coding.code = #XX
* identifier[0].value = "HOS-00001"

* name = "Hospital Central del IPS"

* telecom[0].system = #phone
* telecom[0].value = "+59521234567"

* address.line = "Avenida Mariscal López"
* address.city = "Asunción"
* address.country = "PY"

* type.coding.code = #prov
* type.coding.display = "Healthcare Provider"
```

### 5. ConditionPy

**Campos obligatorios:**
- `subject` (referencia a paciente)
- `code.coding.code` (código CIE-10)
- `code.coding.system = "http://hl7.org/fhir/sid/icd-10"`
- `code.coding.display` (descripción de la condición)
- `code.text` (texto libre en español)

**Campos opcionales recomendados:**
- `verificationStatus`
- `clinicalStatus`
- `note` (observaciones)

**Ejemplo válido:**
```fsh
Instance: DiabetesTipo2Ejemplo
InstanceOf: ConditionPy
Usage: #example
Description: "Condición: Diabetes tipo 2 sin complicaciones"

* meta.profile = "https://mspbs.gov.py/fhir/StructureDefinition/ConditionPy"

* subject = Reference(Patient/PacienteDiabeticoEjemplo)

* code.text = "Diabetes mellitus tipo 2"
* code.coding.code = #E11
* code.coding.system = "http://hl7.org/fhir/sid/icd-10"
* code.coding.display = "Type 2 diabetes mellitus"

* clinicalStatus.coding.code = #active
* verificationStatus.coding.code = #confirmed

* note.text = "Paciente en control regular, últimos valores de glucosa aceptables"
```

### 6. MedicationStatementPy

**Campos obligatorios:**
- `subject` (referencia a paciente)
- `medication` (referencia a medicamento)
- `status` (active | completed | entered-in-error | intended | stopped | on-hold | unknown | not-taken)

**Campos opcionales recomendados:**
- `dosage` (dosis y frecuencia)
- `effectiveDateTime` o `effectivePeriod`
- `note` (observaciones)

**Ejemplo válido:**
```fsh
Instance: MetforminaEjemplo
InstanceOf: MedicationStatementPy
Usage: #example
Description: "Medicamento: Metformina para diabetes tipo 2"

* subject = Reference(Patient/PacienteDiabeticoEjemplo)

* medication[x] only Reference(Medication)
* medicationReference = Reference(Medication/MetforminaRef)

* status = #active

* effectiveDateTime = "2025-01-01"

* dosage.text = "500 mg, 2 veces al día con las comidas"
* dosage.dose.value = 500
* dosage.dose.unit = "mg"
* dosage.timing.repeat.frequency = 2
* dosage.timing.repeat.period = 1
* dosage.timing.repeat.periodUnit = #d

* note.text = "Tomar con alimentos para mejor tolerancia"
```

### 7. AlergiaPy (AllergyIntolerance)

**Campos obligatorios:**
- `patient` (referencia a paciente)
- `code` (código de alérgeno)
- `code.coding.system` (sistema de codificación)
- `reaction` (tipo de reacción)

**Campos opcionales recomendados:**
- `clinicalStatus`
- `verificationStatus`
- `criticality` (low | high | unable-to-assess)
- `note`

**Ejemplo válido:**
```fsh
Instance: AlergiaPenicilinaEjemplo
InstanceOf: AlergiaPy
Usage: #example
Description: "Alergia a penicilina con reacción anafiláctica"

* patient = Reference(Patient/PacienteDiabeticoEjemplo)

* code.coding.system = "http://snomed.info/sct"
* code.coding.code = #91936005
* code.coding.display = "Allergy to penicillin"
* code.text = "Alergia a Penicilina"

* clinicalStatus.coding.code = #active
* verificationStatus.coding.code = #confirmed

* criticality = #high

* reaction.substance.coding.code = #91936005
* reaction.manifestation.coding.code = #39579001
* reaction.manifestation.coding.display = "Anaphylaxis"

* note.text = "Reacción severa con anafilaxia, evitar todas las penicilinas"
```

### 8. CompositionPy

**Campos obligatorios:**
- `status` (preliminary | final | amended | entered-in-error)
- `type` (documento clínico, usar value set apropiado)
- `author` (referencia a profesional)
- `title` (título del documento)
- `section` (secciones del documento)

**Ejemplo válido:**
```fsh
Instance: DocumentoClinicoPrimeraConsultaEjemplo
InstanceOf: CompositionPy
Usage: #example
Description: "Documento: Primera consulta de paciente con diabetes"

* status = #final
* type.coding.code = #34108-1
* type.coding.system = "http://loinc.org"
* type.coding.display = "Outpatient Note"

* subject = Reference(Patient/PacienteDiabeticoEjemplo)
* author = Reference(Practitioner/MedicoCardiologoEjemplo)
* date = 2025-01-15

* title = "Consulta Inicial - Diabetes Tipo 2"

* section[0].title = "Antecedentes"
* section[0].text.status = #generated
* section[0].text.div = "<div>Paciente consulta por primera vez</div>"

* section[1].title = "Diagnóstico"
* section[1].entry = Reference(Condition/DiabetesTipo2Ejemplo)
```

### 9. BundleDocPy

**Estructura:** Bundle que contiene un documento completo

**Ejemplo válido:**
```fsh
Instance: BundleDocumentoParaguayEjemplo
InstanceOf: BundleDocPy
Usage: #example
Description: "Bundle: Documento clínico con paciente, diagnóstico y medicamentos"

* type = #document
* timestamp = 2025-01-15T10:30:00Z

* entry[0].fullUrl = "https://mspbs.gov.py/fhir/Composition/CompositionPy-ejemplo"
* entry[0].resource = InstanceOf(CompositionPy)

* entry[1].fullUrl = "https://mspbs.gov.py/fhir/Patient/PacientePy-ejemplo"
* entry[1].resource = InstanceOf(PacientePy)

* entry[2].fullUrl = "https://mspbs.gov.py/fhir/Condition/ConditionPy-ejemplo"
* entry[2].resource = InstanceOf(ConditionPy)
```

### 10. DocumentReferencePy

**Campos obligatorios:**
- `status` (current | superseded | entered-in-error)
- `content` (referencia o documento)
- `subject` (referencia a paciente)

**Campos opcionales:**
- `type` (tipo de documento)
- `date` (fecha del documento)
- `author` (creador)

**Ejemplo válido:**
```fsh
Instance: ReferenciaPruebaLaboratorioEjemplo
InstanceOf: DocumentReferencePy
Usage: #example
Description: "Referencia a prueba de laboratorio"

* status = #current

* type.coding.code = #18745-0
* type.coding.system = "http://loinc.org"
* type.coding.display = "Hemoglobin and Hematocrit Panel"

* subject = Reference(Patient/PacienteDiabeticoEjemplo)

* author = Reference(Organization/HospitalPublicoEjemplo)

* date = 2025-01-10

* content[0].attachment.contentType = #application/pdf
* content[0].attachment.url = "https://mspbs.gov.py/documentos/laboratorio/hemograma-12345.pdf"
* content[0].attachment.title = "Hemograma Completo"
```

### 11. ListPy

**Campos obligatorios:**
- `status` (current | retired | entered-in-error)
- `mode` (working | snapshot | changes)
- `title` (título de la lista)
- `entry` (elementos de la lista)

**Ejemplo válido:**
```fsh
Instance: ListaMedicamentosActivosEjemplo
InstanceOf: ListPy
Usage: #example
Description: "Lista: Medicamentos activos del paciente"

* status = #current
* mode = #snapshot

* subject = Reference(Patient/PacienteDiabeticoEjemplo)

* title = "Medicamentos Activos"
* code.coding.code = #182836005
* code.coding.system = "http://snomed.info/sct"

* entry[0].item = Reference(MedicationStatement/MetforminaEjemplo)
* entry[1].item = Reference(MedicationStatement/AntihipertensivoEjemplo)
```

### 12. BundleTransaccPy

**Estructura:** Bundle de transacción para operaciones batch

**Ejemplo válido:**
```fsh
Instance: BundleTransaccionEjemplo
InstanceOf: BundleTransaccPy
Usage: #example
Description: "Bundle: Transacción para crear/actualizar paciente y condición"

* type = #transaction
* timestamp = 2025-01-15T10:30:00Z

* entry[0].resource = InstanceOf(Patient)
* entry[0].request.method = #POST
* entry[0].request.url = "Patient"

* entry[1].resource = InstanceOf(Condition)
* entry[1].request.method = #POST
* entry[1].request.url = "Condition"
```

## Mejores Prácticas

### Validación FSH
- ✅ Usar guiones bajos para URLs: `$canonicaPaciente`, `$CIE10VS`
- ✅ Códigos CIE-10 válidos y actualizados
- ✅ Sistemas FHIR estándar: `http://hl7.org/fhir/...`
- ✅ Referencias consistentes: `Reference(Patient/PacientePy-ejemplo)`
- ✅ Timestamps en formato ISO 8601: `2025-01-15T10:30:00Z`

### Contenido de Ejemplos
- ✅ Datos realistas pero despersonalizados
- ✅ Valores de ejemplo paraguayos (teléfonos +595, ciudades reales)
- ✅ Descripciones en español clara
- ✅ Comentarios explicativos para campos complejos
- ✅ Referencias cruzadas cuando sea apropiado

### Evitar
- ❌ Datos personales reales (cédulas, nombres verdaderos)
- ❌ Espacios innecesarios en los valores
- ❌ Códigos CIE-10 inválidos
- ❌ Mezclar idiomas (mantener español)
- ❌ Referencias circulares entre instancias

## Comandos Disponibles

```bash
# Generar ejemplos para un perfil específico
/generador-ejemplos-fsh PacientePy

# Generar para múltiples perfiles
/generador-ejemplos-fsh PacientePy, PractitionerPy, ConditionPy

# Regenerar todos los ejemplos
/generador-ejemplos-fsh todos

# Validar sintaxis de ejemplo existente
/generador-ejemplos-fsh validar [archivo.fsh]
```

## Salida Esperada

La skill generará:

1. **Archivo FSH**: Instancias válidas y funcionales
2. **Documentación**: Comentarios explicativos en cada ejemplo
3. **Validación**: Confirmación de cumplimiento de restricciones
4. **Ubicación**: Carpeta `input/fsh/examples/` del proyecto

## Restricciones de Herramientas

- ✅ Lectura de perfiles FSH existentes
- ✅ Análisis de especificaciones FHIR
- ✅ Búsqueda en value sets y code systems
- ✅ Validación de sintaxis FSH
- ✅ Creación de archivos FSH
- ❌ No modifica perfiles existentes
- ❌ No elimina ejemplos existentes
- ❌ No consulta APIs externas sin autorización

## Contexto Adicional

Este generador está integrado con la IPS Paraguay y conoce:

- Perfiles FHIR definidos en `input/fsh/*.fsh`
- Value sets en `input/fsh/CS_VS.fsh`
- Terminología CIE-10 en `input/fsh/Cie10VS.fsh`
- Estructura de bundles en `input/fsh/Bundle*.fsh`
- Aliases definidos en `input/fsh/Alias.fsh`

## Ejemplos Adicionales

### Solicitud Personalizada
```
/generador-ejemplos-fsh
Perfil: ConditionPy
Escenario: Paciente con hipertensión y diabetes comórbidas
Idioma: español
Incluir: notas clínicas, observaciones
```

### Validación
```
/generador-ejemplos-fsh validar
Archivo: ejemplos-nuevos.fsh
Reportar: errores, warnings, mejoras sugeridas
```

---

**Última actualización:** 15 de abril de 2026  
**Versión:** 1.0  
**Mantenedor:** Team FHIR Paraguay
