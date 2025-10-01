Profile:        OrganizacionPy
Parent:         Organization
Title:          "Organizacion Paraguay"
* ^name = "OrganizacionPy"

* identifier 1.. MS
* identifier.value 1.. MS
* identifier.value ^short = "Número que indica la identificación."

* name MS
* name ^short = "Nombre con el que se designa al establecimiento de salud."

* type MS
* type ^short = "Tipo de establecimiento. Por ejemplo: Hospital, Centro de Salud, etc. "
* type.text MS


/**************************************************************************************************/
Instance: OrganizacionEjemploPy
InstanceOf: OrganizacionPy
Description: "Ejemplo de Organización de Salud."
Usage: #example
* identifier.value = "0005000.00010102"
* name = "HOSPITAL GENERAL DE CORONEL OVIEDO"
* type.text = "HG"

