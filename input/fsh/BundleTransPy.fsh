Profile: BundleTransaccPy
//Parent: https://profiles.ihe.net/ITI/MHD/StructureDefinition/IHE.MHD.Minimal.ProvideBundle
Parent: Bundle
Id: BundleTransaccPy

//------Entradas
* entry MS
* entry ^slicing.discriminator.type = #profile
* entry ^slicing.discriminator.path = "resource"
* entry ^slicing.description = "Corresponde a cada una de las entradas del Bundle."
* entry ^slicing.rules = #closed
* entry.resource MS


* entry contains
    DocumentRefs 1..1 and
    FhirDocuments 1..1 and
    Patient 1..1
  

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


//DocReference -- CASO AMBI
* entry[DocumentRefs].fullUrl = "urn:uuid:487b6713-4647-4a9a-914e-7c552d7197e9"
* entry[DocumentRefs].resource = DocumentReferenceEjemploPy
* entry[DocumentRefs].request.method = #POST
* entry[DocumentRefs].request.url = "DocumentReference"


//Composition
* entry[FhirDocuments].fullUrl = "urn:uuid:d384326c-7c0f-4ac2-ba90-a1d83e5b548f"
* entry[FhirDocuments].resource = BundleDocumentEjemploParaguay
* entry[FhirDocuments].request.method = #POST
* entry[FhirDocuments].request.url = "Bundle"


//Patient
* entry[Patient].fullUrl = "urn:uuid:05d3374b-0278-4d04-93f7-6adc181d5874"
* entry[Patient].resource = PacienteEjemploPy
* entry[Patient].request.method = #POST
* entry[Patient].request.url = "Patient"
