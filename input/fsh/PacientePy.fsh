Profile: PacientePy
Parent:  Patient
Title: "Paciente Paraguay"
Description: "En esta sección se presentará un resumen de la información relacionada con el paciente"
* ^name = "PacientePy"



//---------Nombres y Apellidos
* name 1.. MS
* name ^short = "Nombres y Apellidos del Paciente."
* name ^definition = "Nombre patronímico que aparece en el documento de identidad."

* name.family ^short = "Apellidos del usuario de salud / paciente."
* name.family and name.given MS
* name.family 1..

  
* name.given ^short = "Nombres del paciente."
* name.given 1..



//---------------Sexo    
* gender ^short = "Sexo de nacimiento: male | female | other | unknown (requerido)"
* gender 1..1 MS



//----------Fecha de nacimiento

* birthDate ^short = "Fecha de Nacimiento, formato: YYYY-MM-DD"
* birthDate 1..1


/*------------Identificadores---------------------*/
* identifier ^short = "Identificación del paciente."
* identifier ^definition = "Elemento de dato que contiene el nombre y número de identificación de una determinada persona 
para efectos de identidad e individualización."

* identifier 1.. MS
* identifier.value 1.. MS
* identifier.value ^short = "Número que indica la identificación."

* identifier.type 1.. MS
* identifier.type ^short = "Tipo de indentificación."
* identifier.type.coding.code from IdentificadoresPersonaVS
* identifier.type.coding 1.. MS
* identifier.type.coding.code 1.. MS




//--------------Ejemplo 3 - paciente resumido --------------------------------------------------//
Instance: Paciente
InstanceOf: PacientePy
Description: "Ejemplo de Paciente."

Usage: #example

/** identifier[0].type.coding.system = $cs_identper //* identifier.type.coding.system = $cs_identper
* identifier[0].type.coding.code = #CC //* identifier.type.coding.code = #CC
* identifier[0].type.coding.display = "Cédula ciudadanía"
*/

* identifier[0].type.coding.system = $CSIdentificadoresPersona
* identifier[0].type.coding.code = #01
* identifier[0].type.coding.display = "Cédula de Identidad"

* identifier[0].value = "98765"


* name[0].given = "Luis"
* name[0].family = "Sanchez"

* gender = #male
* birthDate = "1974-12-25"
