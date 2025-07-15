Alias: $RelatedPerson-mother = http://hl7.org/fhir/us/vr-common-library/StructureDefinition/RelatedPerson-mother

Profile: PacientePy
Parent:  Patient
Title: "Paciente Paraguay"
Description: "En esta sección se presentará un resumen de la información relacionada con el paciente"
* ^name = "PacientePy"



//---------Nombres y Apellidos
* name 1.. MS
* name.family and name.given MS
* name.family 1..

* name.family ^short = "Apellidos del usuario de salud / paciente."

//* name.family.extension contains $humanname-mothers-family named SegundoApellido 0..      
  

* name.given 1..
* name.given ^short = "Nombres del paciente."

* name ^short = "Nombres y Apellidos del Paciente."
* name ^definition = "Nombre patronímico que aparece en el documento de identidad."


//---------------Sexo    
* gender ^short = "Sexo de nacimiento: male | female | other | unknown (requerido)"

* gender 1..1 MS



//----------Fecha de nacimiento

* birthDate ^short = "Fecha de Nacimiento, formato: YYYY-MM-DD"
* birthDate 1..1



/*------------Identificadores
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

* identifier.type.extension ^short = "Extension para representar pais del documento."
* identifier.type.extension ^definition = "Se usa esta extensión para agregarle al tipo de documento el país de origen de este" 
* identifier.type.extension contains Pais named pais_emisor 1..1  
*/

//Continente, País, Departamento/Estado, Provincia, Distrito de acuerdo a la codificación que utiliza RENIEC



/* ----------------------------------------------------------------------------------------------------*/
/* -------------------------EXTENSIONES----------------------------------------------------------------*/
/* ----------------------------------------------------------------------------------------------------*/



