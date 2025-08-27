
Profile:        ImmunizationPy
Parent:         Immunization
Title:          "Inmunización Paraguay"
Description:    "Inmunización del paciente"

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