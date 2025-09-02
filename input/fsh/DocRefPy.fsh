Profile: DocumentReferencePy
Parent: DocumentReference
Title: "Referencia de Documentos"
Description: "Documento utilizado para guardar referencias."


* type 1.. MS

/* ???
* type.coding 1..1 MS
* type.coding ^short = "Código del tipo de documento."

* type.coding.code ^short = "Corresponde al tipo de documento que se está enviando"
* type.coding.code 1..1
* type.coding.code from ConjuntoDocumentosVS (required)

* type.coding.system ^short = "Sistema de codificación"
* type.coding.system = "http://loinc.org"
*/


//* --- Fecha -----
* date 1..1 MS
* date ^short = "Fecha de creación del documento"
* date ^definition = "Fecha de creación del documento"


* status 1..1 MS
* status = #current 
* status ^short = "Estado del Documento. Valor Fijo: current"
* status ^definition = "Indica el estado del documento."

//-----------PACIENTE --------- 
* subject 1..1 MS
* subject ^short = "Representa al paciente."

* subject.reference 1..
* subject.reference ^short = "URL que referencia al recurso paciente."


* subject only Reference(PacientePy)


//-----------CUSTODIAN ---------
* custodian 1..1 MS
* custodian ^short = "Establecimiento de salud que custodia el documento."
* custodian only Reference(OrganizacionPy)



//-----------AUTOR ---------
* author 1..1 MS
* author ^short = "Autor del documento."
* author.reference 1..
* author.reference ^short = "URL que indica el autor."

* author only Reference(PractitionerPy)


//-----------Contenido : Composition ---------
* content.attachment MS
* content.attachment ^short = ""
* content.attachment.url 1..1 MS
* content.attachment.url ^short = "Se debe completar URL del Bundle-Document, enviado dentro de la transacción."


/**********************************************************************/

Instance: DocumentReferenceEjemploPy
InstanceOf: DocumentReferencePy 
Usage: #example
Title : "DocumentReference"
Description: "Ejemplo de Document Reference."

* status = #current 
* date = "2025-09-01T10:30:00Z"


* type.coding.system = "http://loinc.org"
* type.coding.code = #34105-7
* type.coding.display = "Nota de consulta"

* subject = Reference(Patient/PacienteEjemploPy)
* custodian = Reference(Organization/OrganizacionEjemploPy)
* author = Reference(PractitionerPy/PractitionerEjemploPy)
* content.attachment.contentType = #application/fhir+json
* content.attachment.url = "Bundle/BundleDocumentEjemploParaguay"


