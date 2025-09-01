Profile: BundleDocPy
Parent: Bundle
Id: BundleDocPy
Title: "Bundle Paraguay"
Description: "Estructura de Documentos y recursos relacionados."
* ^name = "BundleDocPy_Documento"

* type = #document
* timestamp MS
* identifier MS

//------Entradas
* entry MS
* entry ^slicing.discriminator.type = #profile
* entry ^slicing.discriminator.path = "resource"
* entry ^slicing.description = "Corresponde a cada una de las entradas del Bundle."
* entry ^slicing.rules = #closed
* entry.resource MS


* entry contains
    Composition 0..1 and
    Condition 0..* and    
    Alergias 0..* and
    Medicaciones 0..* and    
    Patient 1..1 and
    Organizacion 1..1 and
    Profesional 1..1
  


/*   --------- Compostion ---------*/
* entry[Composition] ^short = "RDA - Composition."
* entry[Composition] ^definition = "Registro Digital de Atención - Composition"

* entry[Composition].resource 1..
* entry[Composition].resource only $canonicaComposition


/* --------- Condition ---------*/
* entry[Condition] ^short = "Condiciones."
* entry[Condition] ^definition = "Corresponden a los diagnosticos."

* entry[Condition].resource 1..
* entry[Condition].resource only $canonicaCondition



/* --------- Alergias ---------*/
* entry[Alergias] ^short = "Alergias/Intolerancias"
* entry[Alergias] ^definition = "Alergias/Intolerancias."

* entry[Alergias].resource 1..
* entry[Alergias].resource only $canonicaAlergia 




/* --------- Medicamentos ---------*/
* entry[Medicaciones] ^short = "Medicamentos"
* entry[Medicaciones] ^definition = "Medicamentos"

* entry[Medicaciones].resource 1..
* entry[Medicaciones].resource only $canonicaMedication 


/* --------- PACIENTE ---------*/
* entry[Patient] ^short = "Paciente"
* entry[Patient] ^definition = "Paciente."

* entry[Patient].resource 1..
* entry[Patient].resource only $canonicaPaciente


/* --------- ORGANIZATION ---------*/
* entry[Organizacion] ^short = "Establecimiento"
* entry[Organizacion] ^definition = "Establecimiento."

* entry[Organizacion].resource 1..
* entry[Organizacion].resource only $canonicaOrganization

/* --------- PROFESIONAL ---------*/
* entry[Profesional] ^short = "Profesional"
* entry[Profesional] ^definition = "Profesional."

* entry[Profesional].resource 1..
* entry[Profesional].resource only $canonicaPractitioner


/*************************************************************************************************/

Instance : BundleDocumentEjemploParaguay
InstanceOf : BundleDocPy
Title : "Bundle IPS - Paraguay"

Usage : #example
Description: "Ejemplo de Bundle"

* meta.profile = $canonicaBundle
* type = #document

* timestamp = "2023-05-01T10:30:00Z"
* identifier.system = "urn:oid"
* identifier.value = "28b95815-76ce-457b-b7ae-a972e527db40"


* entry[0].fullUrl = "Composition/CompositionEjemploParaguay"
* entry[=].resource = CompositionEjemploParaguay

//Condition
* entry[+].fullUrl = "Condition/ConditionEjemploPeru"
* entry[=].resource = ConditionEjemploPeru


//Alergia-Intolerancia
* entry[+].fullUrl = "AllergyIntolerance/AlergiaPeruOtra"
* entry[=].resource = AlergiaPeruOtra


//Alergia-Intolerancia
* entry[+].fullUrl = "AllergyIntolerance/AlergiaPeruMedicamento"
* entry[=].resource = AlergiaPeruMedicamento

//MEdicamentos
* entry[+].fullUrl = "MedicationStatement/MedicationStatementEjemploParaguay"
* entry[=].resource = MedicationStatementEjemploParaguay


//Patient
* entry[+].fullUrl = "Patient/PacienteEjemploParaguay"
* entry[=].resource = PacienteEjemploParaguay

//Organization
//* entry[+].fullUrl = "OrganizacionPe/OrganizacionEstablecimientoEjemplo"
//* entry[=].resource = OrganizacionEstablecimientoEjemplo

//Profesional -- 
* entry[+].fullUrl = "Practitioner/ProfesionalEjemploParaguay"
* entry[=].resource = ProfesionalEjemploParaguay
