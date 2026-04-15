

CodeSystem: IdentificadoresPersonaCS
Id: IdentificadoresPersonaCS
Title: "Identificadores de Persona"
Description: "Conjunto de códigos para identificar a una persona."
* ^name = "IdentificadoresPersonaCS"
* ^experimental = false
* ^caseSensitive = true
* #01   "Cédula de Identidad" "Cédula de Identidad"
* #02   "Cédula Extranjera" "Cédula Extranjera"
* #03   "Pasaporte" "Pasaporte"



ValueSet: IdentificadoresPersonaVS
Id: IdentificadoresPersonaVS
Title: "Identificadores de Persona"
Description:  "Conjunto de valores para los Identificadores de Persona."
* ^experimental = false
* ^version = "1.0.0"
* ^status = #active

* include codes from system IdentificadoresPersonaCS

ValueSet: IdentificadoresProfesionalVS
Title: "Identificadores de Profesional"
Description:  "Conjunto de valores para los Identificadores de Profesional."
* ^experimental = false
* ^version = "1.0.0"
* ^status = #active

* $CSIdentificadoresPersona#01 "Cédula de Identidad" 

