// ============================================================================
// PLANTILLAS Y SNIPPETS PARA GENERACIÓN DE EJEMPLOS FSH
// Generador de Ejemplos FSH - IPS Paraguay
// ============================================================================

// ============================================================================
// PLANTILLA 1: PACIENTE BÁSICO
// ============================================================================
Instance: PlantillaPaciente_BASICO
InstanceOf: PacientePy
Usage: #example
Description: "Plantilla: Paciente básico con datos demograficos"

* identifier[0].type.coding.system = "http://terminology.hl7.org/CodeSystem/v2-0203"
* identifier[0].type.coding.code = #DNI
* identifier[0].value = "[NUMERO_CEDULA]"

* name.family = "[APELLIDOS]"
* name.given = "[NOMBRES]"

* gender = #[male|female|other|unknown]
* birthDate = "[YYYY-MM-DD]"


// ============================================================================
// PLANTILLA 2: PROFESIONAL BÁSICO
// ============================================================================
Instance: PlantillaProfesional_BASICO
InstanceOf: PractitionerPy
Usage: #example
Description: "Plantilla: Profesional con identificación y especialidad"

* identifier[0].type.coding.system = "$CSIdentificadoresProfesional"
* identifier[0].type.coding.code = #01
* identifier[0].type.coding.display = "Cédula de Identidad"
* identifier[0].value = "[NUMERO_CEDULA]"

* name.family = "[APELLIDOS]"
* name.given = "[NOMBRES]"

* telecom[0].system = #phone
* telecom[0].value = "[+595XXXXXXXXX]"

* address.city = "[CIUDAD]"
* address.country = "PY"


// ============================================================================
// PLANTILLA 3: ORGANIZACIÓN BÁSICA
// ============================================================================
Instance: PlantillaOrganizacion_BASICO
InstanceOf: OrganizacionPy
Usage: #example
Description: "Plantilla: Organización de salud paraguaya"

* identifier[0].type.coding.system = "http://terminology.hl7.org/CodeSystem/v2-0203"
* identifier[0].type.coding.code = #XX
* identifier[0].value = "[CODIGO_INSTITUCION]"

* name = "[NOMBRE_ORGANIZACION]"

* telecom[0].system = #phone
* telecom[0].value = "[+595XXXXXXXXX]"

* address.line = "[DIRECCIÓN]"
* address.city = "[CIUDAD]"
* address.country = "PY"

* type.coding.code = #[prov|team|org|jpa|prov]
* type.coding.display = "[Healthcare Provider|Team|Organization]"


// ============================================================================
// PLANTILLA 4: CONDICIÓN/DIAGNÓSTICO CIE-10
// ============================================================================
Instance: PlantillaCondition_BASICO
InstanceOf: ConditionPy
Usage: #example
Description: "Plantilla: Condición con código CIE-10"

* meta.profile = "https://mspbs.gov.py/fhir/StructureDefinition/ConditionPy"

* subject = Reference(Patient/[REFERENCIA_PACIENTE])

* code.text = "[DESCRIPCION_EN_ESPAÑOL]"
* code.coding.code = #[CODIGO_CIE10]
* code.coding.system = "http://hl7.org/fhir/sid/icd-10"
* code.coding.display = "[DESCRIPCION_EN_INGLES]"

* clinicalStatus.coding.code = #[active|recurrence|remission|inactive]
* verificationStatus.coding.code = #[unconfirmed|provisional|differential|confirmed|refuted|entered-in-error]

* note.text = "[OBSERVACIONES_CLINICAS]"


// ============================================================================
// PLANTILLA 5: MEDICAMENTO/MEDICACIÓN
// ============================================================================
Instance: PlantillaMedicamento_BASICO
InstanceOf: MedicationStatementPy
Usage: #example
Description: "Plantilla: Medicamento activo en el paciente"

* subject = Reference(Patient/[REFERENCIA_PACIENTE])

* medicationReference = Reference(Medication/[REFERENCIA_MEDICAMENTO])

* status = #[active|completed|entered-in-error|intended|stopped|on-hold|unknown|not-taken]

* effectiveDateTime = "[YYYY-MM-DDTHH:MM:SSZ]"

* dosage.text = "[DOSIS_Y_FRECUENCIA]"
* dosage.dose.value = [CANTIDAD]
* dosage.dose.unit = "[UNIDAD]"
* dosage.timing.repeat.frequency = [FRECUENCIA]
* dosage.timing.repeat.period = [PERIODO]
* dosage.timing.repeat.periodUnit = #[s|min|h|d|wk|mo|a]

* note.text = "[OBSERVACIONES]"


// ============================================================================
// PLANTILLA 6: ALERGIA/INTOLERANCIA
// ============================================================================
Instance: PlantillaAlergia_BASICO
InstanceOf: AlergiaPy
Usage: #example
Description: "Plantilla: Alergia a sustancia o medicamento"

* patient = Reference(Patient/[REFERENCIA_PACIENTE])

* code.coding.system = "[http://snomed.info/sct|http://hl7.org/fhir/sid/icd-10]"
* code.coding.code = #[CODIGO_ALERGENO]
* code.coding.display = "[NOMBRE_ALERGENO_EN_INGLES]"
* code.text = "[NOMBRE_EN_ESPAÑOL]"

* clinicalStatus.coding.code = #[active|inactive|resolved]
* verificationStatus.coding.code = #[unconfirmed|presumed|confirmed|refuted|entered-in-error]

* criticality = #[low|high|unable-to-assess]

* reaction.substance.coding.code = #[CODIGO]
* reaction.manifestation.coding.code = #[CODIGO_MANIFESTACION]
* reaction.manifestation.coding.display = "[MANIFESTACION]"

* note.text = "[OBSERVACIONES_CLINICAS]"


// ============================================================================
// PLANTILLA 7: DOCUMENTO CLÍNICO
// ============================================================================
Instance: PlantillaComposition_BASICO
InstanceOf: CompositionPy
Usage: #example
Description: "Plantilla: Documento clínico completo"

* status = #[preliminary|final|amended|entered-in-error]
* type.coding.code = #[CODIGO_LOINC]
* type.coding.system = "http://loinc.org"
* type.coding.display = "[TIPO_DOCUMENTO]"

* subject = Reference(Patient/[REFERENCIA_PACIENTE])
* author = Reference(Practitioner/[REFERENCIA_PROFESIONAL])
* date = [YYYY-MM-DD]

* title = "[TITULO_DOCUMENTO]"

* section[0].title = "[SECCION_1]"
* section[0].text.status = #generated
* section[0].text.div = "<div>[CONTENIDO_SECCION]</div>"

* section[1].title = "[SECCION_2]"
* section[1].entry = Reference(Condition/[REFERENCIA_CONDICION])

* section[2].title = "[SECCION_3]"
* section[2].entry[0] = Reference(MedicationStatement/[REFERENCIA_MEDICAMENTO])


// ============================================================================
// PLANTILLA 8: BUNDLE DOCUMENTO
// ============================================================================
Instance: PlantillaBundle_DOCUMENTO
InstanceOf: BundleDocPy
Usage: #example
Description: "Plantilla: Bundle conteniendo documento completo con referencias"

* type = #document
* timestamp = [YYYY-MM-DDTHH:MM:SSZ]

// Entrada 1: Composition (obligatoria, primera)
* entry[0].fullUrl = "https://mspbs.gov.py/fhir/Composition/[ID_COMPOSITION]"
* entry[0].resource = [RECURSO_COMPOSITION]

// Entrada 2: Paciente (obligatorio)
* entry[1].fullUrl = "https://mspbs.gov.py/fhir/Patient/[ID_PACIENTE]"
* entry[1].resource = [RECURSO_PACIENTE]

// Entrada 3+: Recursos referenciados
* entry[2].fullUrl = "https://mspbs.gov.py/fhir/Practitioner/[ID_PROFESIONAL]"
* entry[2].resource = [RECURSO_PROFESIONAL]

* entry[3].fullUrl = "https://mspbs.gov.py/fhir/Organization/[ID_ORGANIZACION]"
* entry[3].resource = [RECURSO_ORGANIZACION]

* entry[4].fullUrl = "https://mspbs.gov.py/fhir/Condition/[ID_CONDICION]"
* entry[4].resource = [RECURSO_CONDICION]


// ============================================================================
// PLANTILLA 9: DOCUMENTO REFERENCIA
// ============================================================================
Instance: PlantillaDocumentReference_BASICO
InstanceOf: DocumentReferencePy
Usage: #example
Description: "Plantilla: Referencia a documento externo"

* status = #[current|superseded|entered-in-error]

* type.coding.code = #[CODIGO_LOINC]
* type.coding.system = "http://loinc.org"
* type.coding.display = "[TIPO_DOCUMENTO]"

* subject = Reference(Patient/[REFERENCIA_PACIENTE])

* author = Reference(Organization/[REFERENCIA_ORGANIZACION])

* date = [YYYY-MM-DD]

* content[0].attachment.contentType = #[application/pdf|text/plain|application/xml|application/json]
* content[0].attachment.url = "[URL_DOCUMENTO]"
* content[0].attachment.title = "[TITULO_DOCUMENTO]"
* content[0].attachment.size = [TAMAÑO_BYTES]


// ============================================================================
// PLANTILLA 10: LISTA CLÍNICA
// ============================================================================
Instance: PlantillaList_BASICO
InstanceOf: ListPy
Usage: #example
Description: "Plantilla: Lista clínica con múltiples entradas"

* status = #[current|retired|entered-in-error]
* mode = #[working|snapshot|changes]

* subject = Reference(Patient/[REFERENCIA_PACIENTE])

* title = "[TITULO_LISTA]"
* code.coding.code = #[CODIGO_SNOMED]
* code.coding.system = "http://snomed.info/sct"
* code.coding.display = "[TIPO_LISTA]"

* entry[0].flag.coding.code = #[ESTADO]
* entry[0].item = Reference([TIPO_RECURSO]/[ID_RECURSO_1])

* entry[1].flag.coding.code = #[ESTADO]
* entry[1].item = Reference([TIPO_RECURSO]/[ID_RECURSO_2])


// ============================================================================
// PLANTILLA 11: BUNDLE TRANSACCIÓN
// ============================================================================
Instance: PlantillaBundle_TRANSACCION
InstanceOf: BundleTransaccPy
Usage: #example
Description: "Plantilla: Bundle para operaciones batch/transacción"

* type = #transaction
* timestamp = [YYYY-MM-DDTHH:MM:SSZ]

// POST: Crear nuevo paciente
* entry[0].resource = [RECURSO_PACIENTE_NUEVO]
* entry[0].request.method = #POST
* entry[0].request.url = "Patient"

// POST: Crear nueva condición
* entry[1].resource = [RECURSO_CONDICION_NUEVA]
* entry[1].request.method = #POST
* entry[1].request.url = "Condition"

// PUT: Actualizar organización existente
* entry[2].resource = [RECURSO_ORGANIZACION_ACTUALIZADO]
* entry[2].request.method = #PUT
* entry[2].request.url = "Organization/[ID_EXISTENTE]"

// DELETE: Eliminar recurso (solo URL)
* entry[3].request.method = #DELETE
* entry[3].request.url = "MedicationStatement/[ID_EXISTENTE]"


// ============================================================================
// CÓDIGOS CIE-10 COMUNES EN PARAGUAY
// ============================================================================
// Diabetes Mellitus
// E10: Type 1 diabetes mellitus
// E11: Type 2 diabetes mellitus
// E13: Other specified diabetes mellitus
// E14: Unspecified diabetes mellitus

// Hipertensión
// I10: Essential (primary) hypertension
// I11: Hypertensive chronic kidney disease
// I12: Hypertensive chronic kidney disease (stages 1-2)
// I13: Hypertensive heart and chronic kidney disease

// Infecciones
// J06.9: Acute upper respiratory infection, unspecified
// J18.9: Pneumonia, unspecified organism
// K29.7: Gastritis, unspecified

// Otros
// I21.9: ST elevation (STEMI) and non-ST elevation (NSTEMI) myocardial infarction of unspecified site
// A18.8: Tuberculosis of other organs

// ============================================================================
// CONSTANTES Y ALIASES UTILIZADOS
// ============================================================================
// $canonicaPaciente = https://mspbs.gov.py/fhir/StructureDefinition/PacientePy
// $canonicaCondition = https://mspbs.gov.py/fhir/StructureDefinition/ConditionPy
// $CIE10VS = http://hl7.org/fhir/ValueSet/icd-10-cm
// $CSIdentificadoresProfesional = https://mspbs.gov.py/fhir/CodeSystem/IdentificadoresProfesional

// ============================================================================
// CONVERSIÓN DE REFERENCIAS
// ============================================================================
// Reference de URL a ID local:
// FROM: "https://mspbs.gov.py/fhir/Patient/3456-789"
// TO:   "Reference(Patient/3456-789)"
// TO:   Reference(Patient/PacientePy-ejemplo)

// ============================================================================
// VALIDACIÓN FSH BÁSICA
// ============================================================================
// 1. Estructura: Instance, InstanceOf, Description
// 2. Datos: tipos de datos correctos (string, code, Reference, etc.)
// 3. Cardinalidad: 1.. (1 o más), 0..1 (opcional), 1..1 (exactamente 1)
// 4. Binding: códigos validados contra Value Sets
// 5. Contenido: sin caracteres especiales no escapados, UTF-8

// ============================================================================
// FIN DE PLANTILLAS
// ============================================================================
