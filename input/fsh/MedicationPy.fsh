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

//* medication[x] only $CUMSvs // $CodeableConcept-uv-ips // or Reference($Medication-uv-ips)
//* medication[x] MS
//* medication[x] ^definition = "....."

* medicationCodeableConcept.text 0..1 MS
* medicationCodeableConcept.text ^short = "Denominación de productos farmacéuticos (Nombre de medicamentos coherentes y concordante)."

* dosage MS
* dosage.text MS
* dosage.text ^short = "Dosis del medicamento."

* dosage.route.text MS
* dosage.route.text ^short = "Vía de administración."

* effectiveDateTime MS
* effectiveDateTime ^short = "Fecha de prescripción."

//Un código que especifica la vía o vía fisiológica de administración de un agente terapéutico en o sobre el cuerpo de un paciente.
  
      //  * dosage.timing MS
      //  only $CodeableConcept-uv-ips
      //  * dosage.route from $medicine-route-of-administration (preferred)
      //  * dosage.route ^binding.description = "EDQM Standards Terms"



//* medicationCodeableConcept only $CUMSvs
//* medicationCodeableConcept from $absent-or-unknown-medications-uv-ips (extensible)
// COLOMBIA : * medicationCodeableConcept from $CUMSvs

/*
* medicationCodeableConcept ^sliceName = "medicationCodeableConcept"
* medicationCodeableConcept ^short = "Code for the medication being administered or an absent or unknown medication"
* medicationCodeableConcept ^definition = "Code for the medication being administered or a negated/excluded medication statement.  If negated, this describes a categorical negated statement (e.g., \"No known medications\")."

    
    * medicationCodeableConcept ^binding.extension.url = "http://hl7.org/fhir/StructureDefinition/elementdefinition-bindingName"
    * medicationCodeableConcept ^binding.extension.valueString = "UnknownMedicationCode"
    * medicationCodeableConcept ^binding.description = "Representation of unknown or absent medications"
    */

    //* medication[x] ^binding.description = "SNOMED CT medications (Pharmaceutical / biologic product) or a code for absent/unknown medication"

    //* medication[x] from $medication-snomed-absent-unknown-uv-ips (preferred)
    //* code from $CUMS (preferred)



    // * code.coding.code from $CIE10VS (preferred) 




        /*

        Alias: $Medication-uv-ips = http://hl7.org/fhir/uv/ips/StructureDefinition/Medication-uv-ips
        Alias: $CodeableConcept-uv-ips = http://hl7.org/fhir/uv/ips/StructureDefinition/CodeableConcept-uv-ips
        Alias: $Patient-uv-ips = http://hl7.org/fhir/uv/ips/StructureDefinition/Patient-uv-ips
        Alias: $data-absent-reason = http://hl7.org/fhir/StructureDefinition/data-absent-reason
        Alias: $medication-example-uv-ips = http://hl7.org/fhir/uv/ips/ValueSet/medication-example-uv-ips
        Alias: $absent-or-unknown-medications-uv-ips = http://hl7.org/fhir/uv/ips/ValueSet/absent-or-unknown-medications-uv-ips
        Alias: $medicine-route-of-administration = http://hl7.org/fhir/uv/ips/ValueSet/medicine-route-of-administration

        Profile: MedicationStatementIPS
        Parent: MedicationStatement
        Id: MedicationStatement-uv-ips
        Title: "Medication Statement (IPS)"
        Description: "This profile represents the constraints applied to the MedicationStatement resource by the International Patient Summary (IPS) FHIR Implementation Guide, based on FHIR R4. A record of a medication statement is represented in the patient summary as an instance of a MedicationStatement resource constrained by this profile."
        * ^version = "1.0.0"
        * ^status = #active
        * ^publisher = "Health Level Seven International - Patient Care Work Group"
        * ^contact.telecom.system = #url
        * ^contact.telecom.value = "http://www.hl7.org/Special/committees/patientcare"
        * ^jurisdiction = http://unstats.un.org/unsd/methods/m49/m49.htm#001
        * ^purpose = "This profile constrains the representation of a medication statement related to the patient, in the context of the international patient summary as specified by the IPS project of HL7 International."
        * status ^comment = "In the scope of the IPS the entered-in-error concept is not allowed."

        * medication[x] MS
        * medication[x] from $medication-example-uv-ips (example)
        * medication[x] ^slicing.discriminator.type = #type
        * medication[x] ^slicing.discriminator.path = "$this"
        * medication[x] ^slicing.rules = #closed
        * medication[x] ^definition = "Identifies the medication being administered or the reason for absent or unknown Medication. This is either a link to a resource representing the details of the medication or a simple attribute carrying a code. To improve global interoperability is strongly encouraged that the reference to a medication resource is used, limiting the usage of the medicationCodeableConcept only to the cases in which no other information than a simple code is available."
        * medication[x] ^binding.description = "The type of medication"

        * medicationReference 0..1 MS
        * medicationReference only Reference($Medication-uv-ips)
        * medicationReference ^sliceName = "medicationReference"

        * medicationCodeableConcept 0..1 MS
        * medicationCodeableConcept only $CodeableConcept-uv-ips
        * medicationCodeableConcept from $absent-or-unknown-medications-uv-ips (extensible)
        * medicationCodeableConcept ^sliceName = "medicationCodeableConcept"
        * medicationCodeableConcept ^short = "Code for the medication being administered or an absent or unknown medication"
        * medicationCodeableConcept ^definition = "Code for the medication being administered or a negated/excluded medication statement.  If negated, this describes a categorical negated statement (e.g., \"No known medications\")."
        * medicationCodeableConcept ^binding.extension.url = "http://hl7.org/fhir/StructureDefinition/elementdefinition-bindingName"
        * medicationCodeableConcept ^binding.extension.valueString = "UnknownMedicationCode"
        * medicationCodeableConcept ^binding.description = "Representation of unknown or absent medications"

        * subject only Reference($Patient-uv-ips)
        * subject MS
        * subject.reference 1.. MS

        * effective[x] 1..1 MS
        * effective[x].extension contains $data-absent-reason named data-absent-reason 0..1 MS
        * effective[x].extension[data-absent-reason] ^short = "effective[x] absence reason"
        * effective[x].extension[data-absent-reason] ^definition = "Provides a reason why the effectiveTime is missing."

        * dosage MS
        * dosage.text MS
        * dosage.timing MS
        * dosage.route only $CodeableConcept-uv-ips
        * dosage.route from $medicine-route-of-administration (preferred)
        * dosage.route ^binding.description = "EDQM Standards Terms"

        */