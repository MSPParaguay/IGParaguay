Profile:        OrganizacionPy
Parent:         Organization
Title:          "Organizacion Paraguay"
Description:    "Organización de Salud, Establecimiento de Paraguay."
* ^name = "OrganizacionPy"

* active ^short = "Estado de si es una Organización Validada o no (true|false)"
* active ^definition = "Indicador si una organización sigue vigente en su rol dentro del sistema de salud"
* active 1..

* identifier 1.. MS
* identifier.value 1.. MS
* identifier.value ^short = "Número que indica la identificación."

//* identifier.type 1.. MS
* identifier.type ^short = "Tipo de indentificación."


* name MS
* name ^short = "Nombre asignado al establecimiento de salud"

* type MS
* type ^short = "Indica el tipo de la organización. " 
* type ^definition = "Indica el tipo de la organización." 


