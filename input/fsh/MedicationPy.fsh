Profile:        MedicationStatementPy
Parent:         MedicationStatement
Title:          "Medication Paraguay"
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




Instance: MedicationStatementEjemploParaguay
InstanceOf: MedicationStatement
Usage: #example
Description: "Ejemplo de MedicationStatement/MedicaciónPaciente."

* meta.profile = $canonicaMedication

* subject = Reference(Patient/PacienteEjemploParaguay)
* status = #active

* medicationCodeableConcept.text = "Paracetamol"

* dosage.text = "1 tableta de 500 mg cada 8 horas"
* dosage.route.text = "Oral"

* effectiveDateTime = "2023-01-02"
