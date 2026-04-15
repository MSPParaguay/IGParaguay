// ============================================================================
// EJEMPLOS ESPECÍFICOS PARA EL PROYECTO FHIR PARAGUAY
// Generador de Ejemplos FSH - IPS Paraguay
// ============================================================================

// Estos ejemplos están basados en los perfiles definidos en el proyecto
// input/fsh/ y son ejemplos completos y funcionales

// ============================================================================
// 1. EJEMPLO: PACIENTE PARAGUAY
// ============================================================================
Instance: PacienteDiabeticoParaguay
InstanceOf: PacientePy
Usage: #example
Description: "Ejemplo de paciente paraguayo adulto con diabetes tipo 2"

* identifier[0].type.coding.system = "http://terminology.hl7.org/CodeSystem/v2-0203"
* identifier[0].type.coding.code = #DNI
* identifier[0].value = "4123456"

* name.family = "González"
* name.given = "María"

* gender = #female
* birthDate = "1975-03-15"

* contact.relationship.coding.code = #emergency
* contact.name.family = "González"
* contact.name.given = "Juan"
* contact.telecom.system = #phone
* contact.telecom.value = "+595981234567"


// ============================================================================
// 2. EJEMPLO: PROFESIONAL SANITARIO
// ============================================================================
Instance: MedicoCardiologoParaguay
InstanceOf: PractitionerPy
Usage: #example
Description: "Ejemplo de médico cardiólogo registrado en Paraguay"

* identifier[0].type.coding.system = "$CSIdentificadoresProfesional"
* identifier[0].type.coding.code = #01
* identifier[0].type.coding.display = "Cédula de Identidad"
* identifier[0].value = "1234567"

* identifier[1].type.coding.system = "$CSIdentificadoresProfesional"
* identifier[1].type.coding.code = #02
* identifier[1].type.coding.display = "Cédula de Profesional"
* identifier[1].value = "MED-12345"

* name.family = "Méndez"
* name.given = "Carlos"

* telecom[0].system = #phone
* telecom[0].value = "+595981234567"
* telecom[0].use = #work

* telecom[1].system = #email
* telecom[1].value = "carlos.mendez@hospital.gov.py"
* telecom[1].use = #work

* address.line = "Calle España 1200"
* address.city = "Asunción"
* address.postalCode = "1500"
* address.country = "PY"


// ============================================================================
// 3. EJEMPLO: ORGANIZACIÓN DE SALUD
// ============================================================================
Instance: HospitalPubilicoParaguay
InstanceOf: OrganizacionPy
Usage: #example
Description: "Ejemplo de hospital público de referencia en Paraguay"

* identifier[0].type.coding.system = "http://terminology.hl7.org/CodeSystem/v2-0203"
* identifier[0].type.coding.code = #XX
* identifier[0].value = "HOS-00001"

* name = "Hospital Central del IPS"

* telecom[0].system = #phone
* telecom[0].value = "+59521345678"
* telecom[0].use = #work

* telecom[1].system = #email
* telecom[1].value = "info@hospitalcentral.gov.py"
* telecom[1].use = #work

* address.line = "Avenida Mariscal López 3348"
* address.city = "Asunción"
* address.postalCode = "1200"
* address.country = "PY"

* type[0].coding.code = #prov
* type[0].coding.display = "Healthcare Provider"


// ============================================================================
// 4. EJEMPLO: CONDICIÓN/DIAGNÓSTICO
// ============================================================================
Instance: DiabetesTipo2Complicaciones
InstanceOf: ConditionPy
Usage: #example
Description: "Ejemplo de condición: Diabetes mellitus tipo 2 con complicaciones renales"

* meta.profile = "https://mspbs.gov.py/fhir/StructureDefinition/ConditionPy"

* subject = Reference(Patient/PacienteDiabeticoParaguay)

* code.text = "Diabetes mellitus tipo 2 con nefropatía"
* code.coding.code = #E11.2
* code.coding.system = "http://hl7.org/fhir/sid/icd-10"
* code.coding.display = "Type 2 diabetes mellitus with kidney complications"

* clinicalStatus.coding.code = #active
* clinicalStatus.coding.system = "http://terminology.hl7.org/CodeSystem/condition-clinical"

* verificationStatus.coding.code = #confirmed
* verificationStatus.coding.system = "http://terminology.hl7.org/CodeSystem/condition-ver-status"

* onsetDateTime = "1995-05-01"

* note.text = "Paciente diagnosticado hace 30 años. Requiere control de glucosa regular. Últimos valores: glucosa 156 mg/dL, HbA1c 7.8%. Presenta proteinuria leve en análisis reciente."


// ============================================================================
// 5. EJEMPLO: MEDICAMENTO/MEDICACIÓN
// ============================================================================
Instance: MetforminaMedicacionActiva
InstanceOf: MedicationStatementPy
Usage: #example
Description: "Ejemplo de medicación activa: Metformina para control de diabetes"

* subject = Reference(Patient/PacienteDiabeticoParaguay)

* medicationReference = Reference(Medication/Metformina500)

* status = #active
* statusReason.coding.code = #refill-requested

* effectiveDateTime = "2024-01-01"

* dateAsserted = "2024-01-01"

* dosage[0].sequence = 1
* dosage[0].text = "Metformina 500 mg, 2 comprimidos 3 veces al día con las comidas"
* dosage[0].timing.repeat.boundsPeriod.start = "2024-01-01"
* dosage[0].timing.repeat.frequency = 3
* dosage[0].timing.repeat.period = 1
* dosage[0].timing.repeat.periodUnit = #d
* dosage[0].timing.repeat.when = #MORN
* dosage[0].route.coding.code = #PO
* dosage[0].dose.value = 1000
* dosage[0].dose.unit = "mg"

* note.text = "Tomar con alimentos para mejor tolerancia gastrointestinal. Si desarrolla síntomas de acidosis láctica, consultar inmediatamente."


// ============================================================================
// 6. EJEMPLO: ALERGIA
// ============================================================================
Instance: AlergiaPenicilinaGrave
InstanceOf: AlergiaPy
Usage: #example
Description: "Ejemplo de alergia grave a penicilina con historial de anafilaxia"

* patient = Reference(Patient/PacienteDiabeticoParaguay)

* code.coding.system = "http://snomed.info/sct"
* code.coding.code = #91936005
* code.coding.display = "Allergy to penicillin"
* code.text = "Alergia a penicilina"

* clinicalStatus.coding.code = #active
* clinicalStatus.coding.system = "http://terminology.hl7.org/CodeSystem/allergyintolerance-clinical"

* verificationStatus.coding.code = #confirmed
* verificationStatus.coding.system = "http://terminology.hl7.org/CodeSystem/allergyintolerance-verification"

* type = #medication

* criticality = #high

* reaction[0].substance.coding.code = #91936005
* reaction[0].manifestation[0].coding.code = #39579001
* reaction[0].manifestation[0].coding.display = "Anaphylaxis"
* reaction[0].severity = #severe
* reaction[0].description = "Reacción anafiláctica con dificultad respiratoria, urticaria generalizada y angioedema"


// ============================================================================
// 7. EJEMPLO: DOCUMENTO CLÍNICO
// ============================================================================
Instance: ConsultaInicial2025
InstanceOf: CompositionPy
Usage: #example
Description: "Ejemplo de documento: Consulta inicial de paciente con diabetes tipo 2"

* status = #final

* type.coding.code = #34108-1
* type.coding.system = "http://loinc.org"
* type.coding.display = "Outpatient Note"

* subject = Reference(Patient/PacienteDiabeticoParaguay)
* author = Reference(Practitioner/MedicoCardiologoParaguay)
* date = 2025-01-15

* title = "Consulta Inicial - Diabetes Mellitus Tipo 2"

* section[0].title = "Motivo de Consulta"
* section[0].text.status = #generated
* section[0].text.div = "<div>Paciente consulta para evaluación de diabetes mellitus tipo 2 y sus complicaciones</div>"

* section[1].title = "Antecedentes Personales"
* section[1].text.status = #generated
* section[1].text.div = "<div>Hipertensión arterial desde hace 15 años. Hiperlipidemia. Antecedente familiar de diabetes.</div>"

* section[2].title = "Diagnósticos"
* section[2].entry[0] = Reference(Condition/DiabetesTipo2Complicaciones)

* section[3].title = "Plan de Tratamiento"
* section[3].entry[0] = Reference(MedicationStatement/MetforminaMedicacionActiva)
* section[3].text.status = #generated
* section[3].text.div = "<div>Continuar con Metformina 1000 mg 3 veces al día</div>"


// ============================================================================
// 8. EJEMPLO: DOCUMENTO EN BUNDLE
// ============================================================================
Instance: BundleDocumentoConsultaCompleto
InstanceOf: BundleDocPy
Usage: #example
Description: "Bundle completo: Documento de consulta con todos los recursos relacionados"

* type = #document
* timestamp = 2025-01-15T10:30:00Z

* entry[0].fullUrl = "https://mspbs.gov.py/fhir/Composition/ConsultaInicial2025"
* entry[0].resource = ConsultaInicial2025

* entry[1].fullUrl = "https://mspbs.gov.py/fhir/Patient/PacienteDiabeticoParaguay"
* entry[1].resource = PacienteDiabeticoParaguay

* entry[2].fullUrl = "https://mspbs.gov.py/fhir/Practitioner/MedicoCardiologoParaguay"
* entry[2].resource = MedicoCardiologoParaguay

* entry[3].fullUrl = "https://mspbs.gov.py/fhir/Organization/HospitalPubilicoParaguay"
* entry[3].resource = HospitalPubilicoParaguay

* entry[4].fullUrl = "https://mspbs.gov.py/fhir/Condition/DiabetesTipo2Complicaciones"
* entry[4].resource = DiabetesTipo2Complicaciones

* entry[5].fullUrl = "https://mspbs.gov.py/fhir/MedicationStatement/MetforminaMedicacionActiva"
* entry[5].resource = MetforminaMedicacionActiva

* entry[6].fullUrl = "https://mspbs.gov.py/fhir/AllergyIntolerance/AlergiaPenicilinaGrave"
* entry[6].resource = AlergiaPenicilinaGrave


// ============================================================================
// 9. EJEMPLO: REFERENCIA A DOCUMENTO
// ============================================================================
Instance: ReferenciaPruebaLaboratorio
InstanceOf: DocumentReferencePy
Usage: #example
Description: "Ejemplo de referencia: Prueba de laboratorio (hemograma y perfil metabólico)"

* status = #current

* docStatus = #final

* type.coding.code = #24588-7
* type.coding.system = "http://loinc.org"
* type.coding.display = "Electrolyte Panel - Serum or Plasma"

* subject = Reference(Patient/PacienteDiabeticoParaguay)

* date = 2025-01-14

* author = Reference(Organization/HospitalPubilicoParaguay)

* title = "Resultados de Laboratorio - Enero 2025"

* content[0].attachment.contentType = #application/pdf
* content[0].attachment.url = "https://mspbs.gov.py/documentos/laboratorio/analisis-2025-01-14.pdf"
* content[0].attachment.title = "Hemograma Completo y Perfil Metabólico"
* content[0].attachment.creation = 2025-01-14


// ============================================================================
// 10. EJEMPLO: LISTA CLÍNICA
// ============================================================================
Instance: ListaMedicamentosActivos
InstanceOf: ListPy
Usage: #example
Description: "Lista: Medicamentos activos del paciente desde 2025"

* status = #current
* mode = #snapshot

* subject = Reference(Patient/PacienteDiabeticoParaguay)

* date = 2025-01-15

* title = "Medicamentos Activos 2025"

* code.coding.code = #182836005
* code.coding.system = "http://snomed.info/sct"
* code.coding.display = "Review of medication"

* source = Reference(Practitioner/MedicoCardiologoParaguay)

* entry[0].date = 2025-01-15
* entry[0].item = Reference(MedicationStatement/MetforminaMedicacionActiva)

* entry[1].date = 2025-01-01
* entry[1].item = Reference(MedicationStatement/AntihipertensivoActivo)


// ============================================================================
// 11. EJEMPLO: BUNDLE TRANSACCIÓN
// ============================================================================
Instance: BundleTransaccionNuevoPaciente
InstanceOf: BundleTransaccPy
Usage: #example
Description: "Bundle transacción: Crear nuevo paciente con diagnosis y medicación"

* type = #transaction
* timestamp = 2025-01-15T11:00:00Z

* entry[0].fullUrl = "urn:uuid:12345678-1234-1234-1234-123456789012"
* entry[0].resource.resourceType = #Patient
* entry[0].resource.name.family = "Rodríguez"
* entry[0].resource.name.given = "Juan"
* entry[0].resource.birthDate = "1960-05-20"
* entry[0].resource.gender = #male
* entry[0].request.method = #POST
* entry[0].request.url = "Patient"

* entry[1].fullUrl = "urn:uuid:87654321-4321-4321-4321-210987654321"
* entry[1].resource.resourceType = #Condition
* entry[1].resource.code.coding.code = #I10
* entry[1].resource.code.coding.system = "http://hl7.org/fhir/sid/icd-10"
* entry[1].resource.clinicalStatus.coding.code = #active
* entry[1].request.method = #POST
* entry[1].request.url = "Condition"


// ============================================================================
// MEDICAMENTOS DE REFERENCIA (para ser usados en ejemplos)
// ============================================================================

ValueSet: MedicamentosParaguayVS
Title: "Medicamentos Comunes en Paraguay"
Description: "Medicamentos frecuentemente utilizados en el sistema de salud paraguayo"
* include codes from system http://www.nlm.nih.gov/research/umls/rxnorm
  where concept descendent-of #D000001

CodeSystem: MedicamentosParaguayCS
Title: "Medicamentos Locales Paraguay"
Description: "Códigos locales para medicamentos utilizados en Paraguay"

* #MF-500mg "Metformina 500 mg"
* #LISIN-10mg "Lisinopril 10 mg"
* #SIMVA-20mg "Simvastatina 20 mg"
* #AAS-100mg "Ácido Acetilsalicílico 100 mg"
* #AMOXIC-500mg "Amoxicilina 500 mg"


// ============================================================================
// FIN DE EJEMPLOS ESPECÍFICOS PARAGUAY
// ============================================================================
