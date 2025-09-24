Profile:        ListPy
Parent:         List

* date 1..1
* date ^short = "Fecha de creación de la lista."
* entry.item only Reference(DocumentReferencePy)
* subject only Reference(PacientePy)
* status = #current
* mode = #working

/***************************************************************

*/

/**********************************************************************/

Instance: ListEjemploPy
InstanceOf: ListPy
Usage: #example
Title : "List"
Description: "Ejemplo de List."

* date = "2025-09-01T10:30:00Z"
* entry.item = Reference(DocumentReference/DocumentReferenceEjemploPy)
* subject = Reference(Patient/PacienteEjemploPy)
* status = #current
* mode = #working
