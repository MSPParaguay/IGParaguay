Profile: BundlePy
Parent: Bundle
Id: BundlePy
Title: "Bundle Paraguay"
Description: "Estructura de transporte de  Documentos y recursos relaciondos."
* ^name = "BundlePy_Documento"

* type = #document
* timestamp MS
* identifier MS

//------Entradas
* entry MS
* entry ^slicing.discriminator.type = #profile
* entry ^slicing.discriminator.path = "resource"
* entry ^slicing.description = "Corresponde a cada una de las entradas del Bundle."
* entry ^slicing.rules = #closed
* entry.resource MS


* entry contains
    Composition 0..1 and
    Condition 0..* and    
    Alergias 0..* and
    Medicaciones 0..* and    
    Patient 1..1 and
    Organizacion 1..1 and
    Profesional 1..1
  


/*   --------- Compostion ---------*/
* entry[Composition] ^short = "RDA - Composition."
* entry[Composition] ^definition = "Registro Digital de Atención - Composition"

* entry[Composition].resource 1..
* entry[Composition].resource only $canonicaComposition

//metodo POST
//* entry[Composition].request 1..
//* entry[Composition].request.method = #POST



/* --------- Condition ---------*/
* entry[Condition] ^short = "Condiciones."
* entry[Condition] ^definition = "Corresponden a los diagnosticos."

* entry[Condition].resource 1..
* entry[Condition].resource only $canonicaCondition



/* --------- Alergias ---------*/
* entry[Alergias] ^short = "Alergias/Intolerancias"
* entry[Alergias] ^definition = "Alergias/Intolerancias."

* entry[Alergias].resource 1..
//* entry[Alergias].resource only $canonicaAlergia 




/* --------- Medicamentos ---------*/
* entry[Medicaciones] ^short = "Medicamentos"
* entry[Medicaciones] ^definition = "Medicamentos"

* entry[Medicaciones].resource 1..
* entry[Medicaciones].resource only $canonicaMedication 
//* entry[Medicaciones].request.method = #POST


/* --------- PACIENTE ---------*/
* entry[Patient] ^short = "Paciente"
* entry[Patient] ^definition = "Paciente."

* entry[Patient].resource 1..
* entry[Patient].resource only $canonicaPaciente


/* --------- ORGANIZATION ---------*/
* entry[Organizacion] ^short = "Establecimiento"
* entry[Organizacion] ^definition = "Establecimiento."

* entry[Organizacion].resource 1..
* entry[Organizacion].resource only $canonicaOrganization

/* --------- PROFESIONAL ---------*/
* entry[Profesional] ^short = "Profesional"
* entry[Profesional] ^definition = "Profesional."

* entry[Profesional].resource 1..
* entry[Profesional].resource only $canonicaPractitioner

/*

/* DE MHD: 
------------------------------------------------------------------------------------------------
* entry contains
    SubmissionSet 1..1 and
    DocumentRefs 0..* and
    Documents 0..* and
    Folders 0..* and
    Patient 0..1

* entry[SubmissionSet] ^short = "the SubmissionSet"
* entry[SubmissionSet] ^definition = "The SubmissionSet defines who submitted it, why they submitted it, when they submitted, what is in it, and where it is destine."
* entry[SubmissionSet].resource 1..
* entry[SubmissionSet].resource only $IHE.MHD.Minimal.SubmissionSet
* entry[SubmissionSet].request 1..
* entry[SubmissionSet].request.method = #POST
*/

/*
* entry[Folders] ^short = "Folders"
* entry[Folders] ^definition = "any Folders being created or updated"
* entry[Folders].resource 1..
* entry[Folders].resource only $IHE.MHD.Minimal.Folder
* entry[Folders].request 1..
* entry[Folders].request.method from $MHDprovideFolderActions (required)
//*entry[Patient].request.method from $MHDprovidePatientActions (required)

/*
* entry[Documents] ^short = "the documents"
* entry[Documents] ^definition = "the documents referenced by the DocumentReference resources"
* entry[Documents].resource 1..
* entry[Documents].resource only Binary
* entry[Documents].request 1..
* entry[Documents].request.method = #POST
*/



