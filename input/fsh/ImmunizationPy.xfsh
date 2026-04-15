
Profile:        ImmunizationPy
Parent:         Immunization
Title:          "Inmunización Paraguay"

//---paciente
* patient only Reference($canonicaPaciente)
* patient MS
* patient.reference 1.. MS

* patient ^short = "Paciente sobre al que corresponde la vacuna."
* patient ^definition = "Paciente sobre al que corresponde la vacuna."

* vaccineCode 1..1 MS
* vaccineCode ^short = "Código de la vacuna."
* vaccineCode ^definition = "Código de la vacuna administrada al paciente."
* vaccineCode.text MS

/************************************************************************************/

Instance: ImmunizationEjemploPy
InstanceOf: ImmunizationPy
Usage: #example
Description: "Ejemplo de Inmunización - Vacuna contra COVID-19."

* status = #completed
* vaccineCode.text = "COVID-19 Vaccine (mRNA)"
* patient = Reference(Patient/PacienteEjemploPy)
* occurrenceDateTime = "2024-03-15"