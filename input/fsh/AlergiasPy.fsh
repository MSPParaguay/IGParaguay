Alias: $abatement-dateTime-uv-ips = http://hl7.org/fhir/uv/ips/StructureDefinition/abatement-dateTime-uv-ips
Alias: $CodeableConcept-uv-ips = http://hl7.org/fhir/uv/ips/StructureDefinition/CodeableConcept-uv-ips
Alias: $Patient-uv-ips = http://hl7.org/fhir/uv/ips/StructureDefinition/Patient-uv-ips
Alias: $allergy-intolerance-uv-ips = http://hl7.org/fhir/uv/ips/ValueSet/allergy-intolerance-uv-ips
Alias: $allergy-reaction-snomed-ct-ips-free-set = http://hl7.org/fhir/uv/ips/ValueSet/allergy-reaction-snomed-ct-ips-free-set



Profile:        AlergiaPy
Parent:         AllergyIntolerance
Title:          "Alergias/Intolerancia Paraguay"

//---paciente
* patient only Reference($canonicaPaciente)
* patient MS
* patient.reference 1.. MS

* patient ^short = "Paciente sobre al que corresponde la alergia."
* patient ^definition = "Paciente sobre al que corresponde la alergia." 

* category 1..1	MS 
* category ^short = "food (comida) | medication (medicación) | environment (medio ambiente) | biologic (biológico)"
* category ^definition = "Categoría de la alergia o intolerancia detectada." 

* criticality MS
* criticality ^short = "low (baja) | high (alta) | unable-to-assess (incapaz de evaluar)"
* criticality ^definition = "Grado de criticidad." 

* reaction MS
* reaction ^short = "Reacción adversa."

* reaction.description MS
* reaction.description ^short = "Descripción de la reacción adversa."

* code.text 1..1 MS 
* code.text ^short = "Descripción de la alergia o intolerancia."

/*IPS */

* code.text 1..1 MS
* code.coding.code 1..1
* code.coding.system 1..1
* code.coding.code from $CIE10VS (preferred) 
* code.coding.system = "http://hl7.org/fhir/sid/icd-10"
* code.coding.display 1..1


/************************************************************************************/


Instance: AlergiaPeruMedicamento
InstanceOf: AlergiaPy
Usage: #example
Description: "Ejemplo Alergia a Medicamento."

* clinicalStatus = #active
* verificationStatus = #confirmed

* code.coding.code = #T36.0X5
* code.coding.system = "http://hl7.org/fhir/sid/icd-10"
* code.text = "alergia a penicilina"
* code.coding.display = "alergia a penicilina"
* patient =  Reference(Patient/PacienteEjemploParaguay) "Paciente Ejemplo"
* category = #medication
