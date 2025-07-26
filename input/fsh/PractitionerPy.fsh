Profile:        PractitionerPy
Parent:         Practitioner
Title:          "Profesional Paraguay"
Description:    "Profesional de Paraguay."
* ^name = "ProfesionalPy"


//------------Identificadores
* identifier ^short = "Identificación del paciente."
* identifier ^definition = "Elemento de dato que contiene el nombre y número de identificación de una determinada persona 
para efectos de identidad e individualización."

* identifier 1.. MS
* identifier.value 1.. MS
* identifier.value ^short = "Número que indica la identificación."


* name 1.. MS
* name.family and name.given MS
* name.family 1..



/*-----------------------------------------
codigo_medico	--> identificador del código del profesional de blanco, con su número de cédula
numero_registro	--> Identifica el numero de registro profesional
codigo_especialidad	--> Identifica el código de la especialidad
------------------------------------------*/
