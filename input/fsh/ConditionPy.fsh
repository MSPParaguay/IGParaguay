Profile:        ConditionPy
Parent:         Condition
Title:          "Condition_Paraguay"
Description:    "Condicion del paciente"
* ^name = "ConditionPy"

//---paciente
* subject only Reference($canonicaPaciente)
* subject MS
* subject.reference 1.. MS

* subject ^short = "Paciente sobre al que corresponde la condición." 
* subject ^definition = "Paciente sobre al que corresponde la condición." 

/*
* code 1..1 MS 
* code from $CIE10VS (preferred)
*/

* code.text 1..1 MS
* code.coding.code 1..1
* code.coding.system 1..1
* code.coding.code from $CIE10VS (preferred) 
* code.coding.system = "http://hl7.org/fhir/sid/icd-10"
* code.coding.display 1..1

* note MS
* note ^short = "Observaciones/anotaciones complementarias." 
* note ^definition = "Observaciones/anotaciones complementarias"

* verificationStatus MS
* verificationStatus ^short = "unconfirmed | provisional | differential | confirmed | refuted | entered-in-error" 


/********************************************************************************************************/
Alias: $condition-ver-status = http://terminology.hl7.org/CodeSystem/condition-ver-status

Instance: ConditionEjemploParaguay
InstanceOf: ConditionPy
Usage: #example
Description: "Ejemplo de Condición/Antecedente de Paciente."

* meta.profile = $canonicaCondition

* subject = Reference(Patient/PacienteEjemploPy)

* code = http://hl7.org/fhir/sid/icd-10#E10.4 "Type 1 diabetes mellitus : With neurological complications"

* code.text = "Diabetes Tipo 1, con complicaciones neurologicas"
* code.coding.code = #E10.4 
* code.coding.system = "http://hl7.org/fhir/sid/icd-10"
* code.coding.display = "Type 1 diabetes mellitus : With neurological complications"

* verificationStatus = $condition-ver-status#confirmed
* onsetPeriod.start =   "2023-01-13"

* note.text = "Antecedentes de diabetes de tipo 1"

