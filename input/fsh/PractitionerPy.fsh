Profile:        PractitionerPy
Parent:         Practitioner
Title:          "Profesional Paraguay"
* ^name = "ProfesionalPy"


//------------Identificadores
* identifier ^short = "Identificación del profesional."
* identifier ^definition = "Elemento de dato que contiene el nombre y número de identificación de una determinada persona 
para efectos de identidad e individualización."

* identifier 1.. MS
* identifier.value 1.. MS
* identifier.value ^short = "Número que indica la identificación."

* identifier.type 1.. MS
* identifier.type ^short = "Tipo de indentificación."
* identifier.type.coding.code from IdentificadoresProfesionalVS
* identifier.type.coding 1.. MS
* identifier.type.coding.code 1.. MS



* name 1.. MS
* name.family and name.given MS
* name.family 1..



/*-----------------------------------------
codigo_medico	--> identificador del código del profesional de blanco, con su número de cédula
numero_registro	--> Identifica el numero de registro profesional
codigo_especialidad	--> Identifica el código de la especialidad
------------------------------------------*/

Instance: PractitionerEjemploPy
InstanceOf: PractitionerPy
Description: "Ejemplo de Profesional."

* name.family = "Doe"
* name.given = "John"

* identifier[0].type.coding.system = $CSIdentificadoresProfesional
* identifier[0].type.coding.code = #01
* identifier[0].type.coding.display = "Cédula de Identidad"

* identifier[0].value = "5555555"
