Profile:        MedicationStatementPy
Parent:         MedicationStatement
Title:          "Medication Paraguay"
Description:    "Medicación del paciente"
* ^name = "MedicationStatementPy"

//---paciente
* subject only Reference($canonicaPaciente)
* subject MS
* subject.reference 1.. MS

* subject ^short = "Paciente sobre al que corresponde la Medicacion." 
* subject ^definition = "Paciente sobre al que corresponde la Medicacion." 

* status MS

* medicationCodeableConcept.text 0..1 MS
* medicationCodeableConcept.text ^short = "Denominación de productos farmacéuticos (Nombre de medicamentos coherentes y concordante)."

* dosage MS
* dosage.text MS
* dosage.text ^short = "Dosis del medicamento."

* dosage.route.text MS
* dosage.route.text ^short = "Vía de administración."

* effectiveDateTime MS
* effectiveDateTime ^short = "Fecha de prescripción."
