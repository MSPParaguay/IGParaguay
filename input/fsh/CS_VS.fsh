

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

// /***********************************************************************************/
// CodeSystem: CIE10ParaguayCS
// Id: CIE10ParaguayCS
// Title: "CIE-10 Paraguay"
// Description: "Códigos de la Clasificación Internacional de Enfermedades (CIE-10) con descripciones en español para Paraguay"
// * ^experimental = false
// * ^caseSensitive = true
// * ^content = #fragment
// * ^url = "https://mspbs.gov.py/fhir/CodeSystem/CIE10ParaguayCS"

// // Enfermedades Infecciosas y Parasitarias (A00-B99)
// * #A00 "Cólera"
// * #A00.0 "Cólera debido a Vibrio cholerae 01, biotipo cholerae"
// * #A00.1 "Cólera debido a Vibrio cholerae 01, biotipo El Tor"
// * #A00.9 "Cólera, no especificado"
// * #A01 "Fiebres tifoidea y paratifoidea"
// * #A01.0 "Fiebre tifoidea"
// * #A01.1 "Fiebre paratifoidea A"
// * #A01.2 "Fiebre paratifoidea B"
// * #A01.3 "Fiebre paratifoidea C"
// * #A01.4 "Fiebre paratifoidea, no especificada"
// * #A02 "Otras infecciones debidas a Salmonella"
// * #A02.0 "Enteritis debida a Salmonella"
// * #A09 "Diarrea y gastroenteritis de presunto origen infeccioso"

// // Enfermedades Endocrinas, Nutricionales y Metabólicas (E00-E90)
// * #E10 "Diabetes mellitus insulinodependiente"
// * #E10.0 "Diabetes mellitus insulinodependiente, con coma"
// * #E10.1 "Diabetes mellitus insulinodependiente, con cetoacidosis"
// * #E10.2 "Diabetes mellitus insulinodependiente, con complicaciones renales"
// * #E10.9 "Diabetes mellitus insulinodependiente, sin mención de complicación"
// * #E11 "Diabetes mellitus no insulinodependiente"
// * #E11.0 "Diabetes mellitus no insulinodependiente, con coma"
// * #E11.1 "Diabetes mellitus no insulinodependiente, con cetoacidosis"
// * #E11.2 "Diabetes mellitus no insulinodependiente, con complicaciones renales"
// * #E11.3 "Diabetes mellitus no insulinodependiente, con complicaciones oftálmicas"
// * #E11.4 "Diabetes mellitus no insulinodependiente, con complicaciones neurológicas"
// * #E11.5 "Diabetes mellitus no insulinodependiente, con complicaciones circulatorias periféricas"
// * #E11.6 "Diabetes mellitus no insulinodependiente, con otras complicaciones especificadas"
// * #E11.9 "Diabetes mellitus no insulinodependiente, sin mención de complicación"
// * #E14 "Diabetes mellitus, no especificada"
// * #E14.9 "Diabetes mellitus, no especificada, sin mención de complicación"
// * #E66 "Obesidad"
// * #E66.0 "Obesidad debida a exceso de calorías"
// * #E66.1 "Obesidad inducida por drogas"
// * #E66.2 "Obesidad extrema con hipoventilación alveolar"
// * #E66.8 "Otras obesidades"
// * #E66.9 "Obesidad, no especificada"

// // Enfermedades del Sistema Circulatorio (I00-I99)
// * #I10 "Hipertensión esencial (primaria)"
// * #I11 "Enfermedad cardíaca hipertensiva"
// * #I11.0 "Enfermedad cardíaca hipertensiva con insuficiencia cardíaca (congestiva)"
// * #I11.9 "Enfermedad cardíaca hipertensiva sin insuficiencia cardíaca (congestiva)"
// * #I12 "Enfermedad renal hipertensiva"
// * #I13 "Enfermedad cardíaca y renal hipertensiva"
// * #I20 "Angina de pecho"
// * #I21 "Infarto agudo del miocardio"
// * #I21.0 "Infarto transmural agudo del miocardio de la pared anterior"
// * #I21.1 "Infarto transmural agudo del miocardio de la pared inferior"
// * #I21.2 "Infarto transmural agudo del miocardio de otros sitios"
// * #I21.3 "Infarto transmural agudo del miocardio, de sitio no especificado"
// * #I21.4 "Infarto subendocárdico agudo del miocardio"
// * #I21.9 "Infarto agudo del miocardio, sin otra especificación"
// * #I50 "Insuficiencia cardíaca"
// * #I50.0 "Insuficiencia cardíaca congestiva"
// * #I50.1 "Insuficiencia ventricular izquierda"
// * #I50.9 "Insuficiencia cardíaca, no especificada"

// // Enfermedades del Sistema Respiratorio (J00-J99)
// * #J00 "Rinofaringitis aguda [resfriado común]"
// * #J01 "Sinusitis aguda"
// * #J02 "Faringitis aguda"
// * #J03 "Amigdalitis aguda"
// * #J06 "Infecciones agudas de las vías respiratorias superiores, de sitios múltiples o no especificados"
// * #J06.9 "Infección aguda de las vías respiratorias superiores, no especificada"
// * #J11 "Influenza [gripe] debida a virus no identificado"
// * #J11.0 "Influenza debida a virus no identificado, con neumonía"
// * #J11.1 "Influenza debida a virus no identificado, con otras manifestaciones respiratorias"
// * #J18 "Neumonía, organismo no especificado"
// * #J18.0 "Bronconeumonía, no especificada"
// * #J18.1 "Neumonía lobar, no especificada"
// * #J18.9 "Neumonía, no especificada"
// * #J20 "Bronquitis aguda"
// * #J40 "Bronquitis, no especificada como aguda o crónica"
// * #J44 "Otras enfermedades pulmonares obstructivas crónicas"
// * #J45 "Asma"
// * #J45.0 "Asma predominantemente alérgica"
// * #J45.1 "Asma no alérgica"
// * #J45.8 "Asma mixta"
// * #J45.9 "Asma, no especificada"

// // Enfermedades del Sistema Digestivo (K00-K93)
// * #K29 "Gastritis y duodenitis"
// * #K29.0 "Gastritis aguda hemorrágica"
// * #K29.1 "Otras gastritis agudas"
// * #K29.2 "Gastritis alcohólica"
// * #K29.3 "Gastritis crónica superficial"
// * #K29.4 "Gastritis crónica atrófica"
// * #K29.5 "Gastritis crónica, no especificada"
// * #K29.9 "Gastroduodenitis, no especificada"

// // Embarazo, Parto y Puerperio (O00-O99)
// * #O00 "Embarazo ectópico"
// * #O10 "Hipertensión preexistente que complica el embarazo, el parto y el puerperio"
// * #O11 "Trastornos hipertensivos preexistentes, con proteinuria agregada"
// * #O80 "Parto único espontáneo"
// * #O81 "Parto único con fórceps o ventosa extractora"
// * #O82 "Parto único por cesárea"

// // COVID-19 (U00-U99)
// * #U07.1 "COVID-19, virus identificado"
// * #U07.2 "COVID-19, virus no identificado"

// ValueSet: CIE10VS
// Id: CIE10VS
// Title: "Codificación CIE-10 ValueSet"
// Description: "Conjunto de Valores de Codificación CIE-10 en español para Paraguay"
// * ^experimental = false
// * ^version = "1.0.0"
// * ^status = #active

// * include codes from system CIE10ParaguayCS
