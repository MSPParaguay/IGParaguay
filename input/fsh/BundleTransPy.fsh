Profile: BundleTransaccPy
//Parent: https://profiles.ihe.net/ITI/MHD/StructureDefinition/IHE.MHD.Minimal.ProvideBundle
Parent: Bundle
Id: BundleTransaccPy
Description:    "Perfil para representar un Bundle de transacción en el contexto de Paraguay, incluyendo información sobre el tipo de transacción, timestamp y entradas correspondientes a recursos como List, DocumentReference, Composition, Condition, AllergyIntolerance, MedicationStatement, Patient, Organization y Practitioner."
Title: "Bundle Transaccional Paraguay"

//------Entradas
* entry MS
* entry ^slicing.discriminator.type = #profile
* entry ^slicing.discriminator.path = "resource"
* entry ^slicing.description = "Corresponde a cada una de las entradas del Bundle."
* entry ^slicing.rules = #closed
* entry.resource MS


* entry contains
    List 1..1 and
    DocumentRefs 1..1 and
    FhirDocuments 1..1 and
    Patient 1..1
  

* entry[List].resource 1..1
* entry[List].resource only ListPy

* entry[DocumentRefs].resource 1..1
* entry[DocumentRefs].resource only DocumentReferencePy

* entry[FhirDocuments].resource 1..1
* entry[FhirDocuments].resource only BundleDocPy

* entry[Patient].resource 1..1
* entry[Patient].resource only PacientePy

/*------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------*/


Instance : BundleTrancEjemploPy
InstanceOf : BundleTransaccPy
Title : "Bundle Transaccional Paraguay"
Usage : #example
Description: "Ejemplo de Bundle de transacción."

* type = #transaction


* timestamp = "2022-03-03T10:30:00Z"

* entry[List].fullUrl = "urn:uuid:1c3f3b6e-3f4e-4c5a-9e2b-1e8f0c8b9c6d"
* entry[List].resource = ListEjemploPy2
* entry[List].request.method = #POST
* entry[List].request.url = "List"

//DocReference -- CASO AMBI
* entry[DocumentRefs].fullUrl = "urn:uuid:487b6713-4647-4a9a-914e-7c552d7197e9"
* entry[DocumentRefs].resource = DocumentReferenceEjemploPy2
* entry[DocumentRefs].request.method = #POST
* entry[DocumentRefs].request.url = "DocumentReference"


//Composition
* entry[FhirDocuments].fullUrl = "urn:uuid:d384326c-7c0f-4ac2-ba90-a1d83e5b548f"
* entry[FhirDocuments].resource = BundleDocumentEjemploParaguay2
* entry[FhirDocuments].request.method = #POST
* entry[FhirDocuments].request.url = "Bundle"


//Patient
* entry[Patient].fullUrl = "urn:uuid:05d3374b-0278-4d04-93f7-6adc181d5874"
* entry[Patient].resource = PacienteEjemploPy
* entry[Patient].request.method = #POST
* entry[Patient].request.url = "Patient"


/*****************************************************************/
/*********************************/


Instance: ListEjemploPy2
InstanceOf: ListPy
Usage: #example
Title : "List"
Description: "Ejemplo de List 2."

* date = "2025-09-01T10:30:00Z"
* entry.item.reference = "urn:uuid:487b6713-4647-4a9a-914e-7c552d7197e9"
* subject.reference = "urn:uuid:05d3374b-0278-4d04-93f7-6adc181d5874"
* status = #current
* mode = #working



Instance: DocumentReferenceEjemploPy2
InstanceOf: DocumentReferencePy 
Usage: #example
Title : "DocumentReference"
Description: "Ejemplo de Document Reference 2."

* status = #current 
* date = "2025-09-01T10:30:00Z"


* type.coding.system = "http://loinc.org"
* type.coding.code = #34105-7
* type.coding.display = "Nota de consulta"

* subject.reference = "urn:uuid:05d3374b-0278-4d04-93f7-6adc181d5874"
* custodian = Reference(Organization/OrganizacionEjemploPy)
* author = Reference(PractitionerPy/PractitionerEjemploPy)
* content.attachment.contentType = #application/fhir+json
* content.attachment.url = "urn:uuid:d384326c-7c0f-4ac2-ba90-a1d83e5b548f"





