Alias: $loinc = http://loinc.org

Profile: CompositionPy
Parent: Composition
Id: CompositionPy
Title: "Documento Clinico Paraguay"
Description: "Información Clinica Basica Paraguay"
* ^name = "CompositionPy"

//* text MS
//* identifier MS

* status MS
* status ^short = "Estado valor fijo: -final-"
* status ^definition = "Corresponde al estado del documento."

//--- loinc que representa el tipo de documento ----
* type from http://hl7.org/fhir/ValueSet/doc-typecodes (preferred)
* type MS
* type ^short = "Tipo de Documento"
* type ^definition = "Especifica el tipo de documento que se ha generado"


//* ---- Paciente ----- 
* subject 1..1 
* subject only Reference($canonicaPaciente)
* subject MS
* subject ^definition = "Corresponde al paciente al que se refiere el documento."
* subject ^short = "Paciente"
* subject.reference 1..1 MS
* subject.reference ^short = "Corresponde al paciente"



//* --- Author : referencia a un practitioner----
* author 1..1 
* author only Reference($canonicaPractitioner) 
* author MS
* author ^short = "Quien Ha creado el documento"
* author ^definition = "Identifica al responsable de los datos ingresados al documento."

//* --- Custodio : referencia a una organización----
* custodian 1..1
* custodian only Reference($canonicaOrganization) 
* custodian MS
* custodian ^short = "Establecimiento de salud que custodia el documento."
* custodian ^definition = "Establecimiento de salud que custodia el documento."

//* --- Fecha -----
* date MS
* date ^short = "Fecha de creación del documento"
* date ^definition = "Fecha de creación del documento"

//* --- Titulo de documento -----
* title MS
* title ^short = "Título del documento generado"
* title ^definition = "Título del documento generado"


* section 1.. MS

//----- division de secciones -------
* section ^slicing.discriminator[0].type = #pattern
* section ^slicing.discriminator[=].path = "code"
* section ^slicing.ordered = false
* section ^slicing.rules = #open

* section ^short = "Sección del documento"
* section ^definition = "Sección de notificación de datos clínicos."

* section.code 1.. MS
* section.code from http://hl7.org/fhir/ValueSet/doc-section-codes (example)


//--------- Secciones 
* section contains
    sectionDiagnosticos 0.. MS and
    sectionMedicacion 0.. MS and
    sectionAlergias 0.. MS

  
//------ 1. Diagnosticos------------

* section[sectionDiagnosticos] ^short = "Sección Diagnósticos"
* section[sectionDiagnosticos] ^definition = "Descripción de lista de diagnósticos determinados en el paciente."

* section[sectionDiagnosticos].code MS 
* section[sectionDiagnosticos].code = $loinc#11450-4

* section[sectionDiagnosticos].title 1.. MS

* section[sectionDiagnosticos].entry 1.. MS
* section[sectionDiagnosticos].entry only Reference($canonicaCondition)

* section[sectionDiagnosticos].entry ^slicing.discriminator[0].type = #profile
* section[sectionDiagnosticos].entry ^slicing.discriminator[=].path = "resolve()"
* section[sectionDiagnosticos].entry ^slicing.rules = #open
* section[sectionDiagnosticos].entry ^short = "Diagnósticos conocidos actualmente de relevancia para determinaciones clínicas en el paciente."



//------ 2. Medicacion------------

* section[sectionMedicacion] ^short = "Sección Medicacion"
* section[sectionMedicacion] ^definition = "Descripción de lista de medicacion del paciente."

* section[sectionMedicacion].code MS 
* section[sectionMedicacion].code = $loinc#10160-0
* section[sectionMedicacion].title 1.. MS
* section[sectionMedicacion].entry 1.. MS
* section[sectionMedicacion].entry only Reference($canonicaMedication)

* section[sectionMedicacion].entry ^slicing.discriminator[0].type = #profile
* section[sectionMedicacion].entry ^slicing.discriminator[=].path = "resolve()"
* section[sectionMedicacion].entry ^slicing.rules = #open
* section[sectionMedicacion].entry ^short = "Medicación del paciente."


//------ 3. Alergias------------

* section[sectionAlergias] ^short = "Sección Alergias"
* section[sectionAlergias] ^definition = "Descripción de lista de alergias conocidas del paciente."

* section[sectionAlergias].code MS 
* section[sectionAlergias].code = $loinc#48765-2
* section[sectionAlergias].title 1.. MS
* section[sectionAlergias].entry 1.. MS
//* section[sectionAlergias].entry only Reference($canonicaAlergia) 

* section[sectionAlergias].entry ^slicing.discriminator[0].type = #profile
* section[sectionAlergias].entry ^slicing.discriminator[=].path = "resolve()"
* section[sectionAlergias].entry ^slicing.rules = #open
* section[sectionAlergias].entry ^short = "Alergias del paciente."



//-------------- Ejemplo Composition--------------------------------------------------/


Instance: CompositionEjemploPy
InstanceOf: CompositionPy
Description: "Ejemplo de Documento-Composition."

Usage: #example

* type = $loinc#11450-4
* subject = Reference(Patient/PacienteEjemploPy)
* author = Reference(Practitioner/PractitionerEjemploPy)
* custodian = Reference(Organization/OrganizacionEjemploPy)
* status = #final
* title = "Resumen Digital en Atención - Ejemplo Paraguay"
* date = "2025-09-01"

* section[sectionDiagnosticos].code = $loinc#11450-4
* section[sectionDiagnosticos].title = "Diagnósticos"
* section[sectionDiagnosticos].entry = Reference(Condition/ConditionEjemploParaguay)

* section[sectionMedicacion].code = $loinc#10160-0
* section[sectionMedicacion].title = "Medicación Actual"
* section[sectionMedicacion].entry = Reference(MedicationStatement/MedicationStatementEjemploParaguay)

* section[sectionAlergias].code = $loinc#48765-2
* section[sectionAlergias].title = "Alergias Conocidas"
* section[sectionAlergias].entry = Reference(AllergyIntolerance/AlergiaPeruMedicamento)
* title = "Ejemplo de Documento Clinico Paraguay"
* status = #final


* section[0].title = "Diagnósticos"

* section[=].code = http://loinc.org#11450-4 "Problem list Reported"
* section[=].text.status = #generated
* section[=].text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\">Diagnósticos</div>"
* section[=].entry = Reference(Condition/ConditionEjemploParaguay)

/*
* section[1].title = "Alergias"

* section[=].code = http://loinc.org#11450-4 "Problem list Reported"
* section[=].text.status = #generated
* section[=].text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\">Alergias</div>"
* section[=].entry = Reference(Condition/ConditionEjemploParaguay)
*/


/******************************************************************************************************************/

/*

Instance: CompositionEjemploPy
InstanceOf: Composition
Usage: #example
Description: "Ejemplo de Documento Resumen de Paciente Perú."

* meta.versionId = "1"
* meta.lastUpdated = "2023-05-13T18:23:44.162Z"
* meta.profile = $canonicaComposition 

* type = $loinc#60591-5 "Patient Summary Document"

* subject = Reference(Patient/PacienteEjemploPy)
* date = "2023-03-05T18:30:00+01:00"
* status = #final

/* otra forma de referencial al profesional, solo con la identificacion.
* author.identifier.type.coding.system = $cs_identper#CC
* author.identifier.value = "12345"
*/

/*
* author = Reference(Practitioner/ProfesionalEjemploPy)
* title = "Resumen de Paciente IPS - Paraguay"

* custodian = Reference(Organization/OrganizacionEstablecimientoEjemplo)

// ------- seccion de condition, problemas activos.
* section[0].title = "Condiciones del Paciente"

* section[=].code = http://loinc.org#11450-4 "Problem list Reported"
* section[=].text.status = #generated
* section[=].text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\">CONDICIONES</div>"
* section[=].entry = Reference(Condition/ConditionEjemploPy)


// ------- seccion de medicamentos
* section[+].title = "Medicamentos"

* section[=].code = http://loinc.org#10160-0 "Hx of Medication use"
* section[=].text.status = #generated
* section[=].text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\">MEDICAMENTOS</div>"
* section[=].entry = Reference(MedicationStatement/MedicationStatementEjemploPy)


// ------- seccion de Alergias
* section[+].title = "Alergias"

* section[=].code = http://loinc.org#48765-2 "Allergies and adverse reactions Document."
* section[=].text.status = #generated
* section[=].text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\">ALERGIAS</div>"
* section[=].entry = Reference(AllergyIntolerance/AlergiaEjemploPy)
/*******************************************************************************************************************/


