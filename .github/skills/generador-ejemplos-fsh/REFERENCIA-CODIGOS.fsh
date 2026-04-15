// ============================================================================
// REFERENCIA RÁPIDA DE CÓDIGOS Y SISTEMAS
// Generador de Ejemplos FSH - IPS Paraguay
// ============================================================================

// ============================================================================
// CIE-10: CÓDIGOS DIAGNÓSTICOS COMUNES EN PARAGUAY
// ============================================================================
/*
SISTEMA: http://hl7.org/fhir/sid/icd-10

DIABETES MELLITUS
E10.0 - Type 1 diabetes mellitus with hyperosmolarity
E10.1 - Type 1 diabetes mellitus with ketoacidosis
E10.2 - Type 1 diabetes mellitus with hypoglycemia
E10.3 - Type 1 diabetes mellitus with ophthalmic complications
E10.4 - Type 1 diabetes mellitus with neurological complications
E10.5 - Type 1 diabetes mellitus with circulatory complications
E10.6 - Type 1 diabetes mellitus with other specified complications
E10.8 - Type 1 diabetes mellitus with unspecified complications
E10.9 - Type 1 diabetes mellitus without complications

E11.0 - Type 2 diabetes mellitus with hyperosmolarity
E11.1 - Type 2 diabetes mellitus with ketoacidosis
E11.2 - Type 2 diabetes mellitus with kidney complications
E11.3 - Type 2 diabetes mellitus with ophthalmic complications
E11.4 - Type 2 diabetes mellitus with neurological complications
E11.5 - Type 2 diabetes mellitus with circulatory complications
E11.6 - Type 2 diabetes mellitus with other specified complications
E11.8 - Type 2 diabetes mellitus with unspecified complications
E11.9 - Type 2 diabetes mellitus without complications

HIPERTENSIÓN
I10    - Essential (primary) hypertension
I11    - Hypertensive chronic kidney disease
I12.0  - Hypertensive chronic kidney disease with stage 1 through stage 3 chronic kidney disease
I13.0  - Hypertensive heart and chronic kidney disease with heart failure and stage 1 through stage 3 chronic kidney disease, or unspecified chronic kidney disease

ENFERMEDADES CIRCULATORIAS
I20    - Angina
I21    - ST elevation myocardial infarction (STEMI) and non-ST elevation myocardial infarction (NSTEMI)
I25.1  - Atherosclerotic heart disease of native coronary artery

INFECCIONES RESPIRATORIAS
J06.9  - Acute upper respiratory infection, unspecified
J18.9  - Pneumonia, unspecified organism
J20.9  - Acute bronchitis, unspecified
J40    - Bronchitis, not specified as acute or chronic

ENFERMEDADES GASTROINTESTINALES
K29.7  - Gastritis, unspecified
K30    - Functional dyspepsia
K21.9  - Unspecified reflux esophagitis

TUBERCULOSIS
A15.0  - Tuberculosis of lung
A15.9  - Respiratory tuberculosis unspecified
A18.8  - Tuberculosis of other organs

HIPERCOLESTEROLEMIA
E78.0  - Pure hypercholesterolemia
E78.2  - Mixed hyperlipidemia
E78.5  - Lipoid storage disorder

PROBLEMAS DE SALUD MENTAL
F32.9  - Major depressive disorder, single episode, unspecified
F41.1  - Generalized anxiety disorder
F90.9  - Attention-deficit/hyperactivity disorder, unspecified
*/

// ============================================================================
// LOINC: CÓDIGOS DE PRUEBAS DE LABORATORIO
// ============================================================================
/*
SISTEMA: http://loinc.org

HEMOGRAMA
2345-7    - Hemoglobin [Mass/volume] in Blood
789-8     - Erythrocytes [#/volume] in Blood by Automated count
4544-3    - Hematocrit [Volume Fraction] of Blood by Automated count

QUÍMICA SANGUÍNEA
2160-0    - Creatinine [Mass/volume] in Serum or Plasma
3094-0    - Urea nitrogen [Mass/volume] in Serum or Plasma
2885-2    - Glucose [Mass/volume] in Blood

PERFIL LIPÍDICO
2571-8    - Triglycerides [Mass/volume] in Serum or Plasma
2093-3    - Cholesterol [Mass/volume] in Serum or Plasma
2083-3    - Cholesterol [Mass/volume] in HDL in Serum or Plasma
18262-6   - Low Density Lipoprotein Cholesterol (LDL) [Mass/volume] in Serum or Plasma

PRUEBAS INFECCIOSAS
34532-2   - Respiratory syncytial virus (RSV) Ag [Presence] in Respiratory specimen by Immunofluorescence
11562-0   - Influenza virus A and B identified in Respiratory specimen by Culture
22587-5   - Human immunodeficiency virus (HIV) 1 [Presence] in Serum or Plasma by Immunoassay (HIV Ab)

PRUEBAS RADIOLÓGICAS
36643-5   - Chest X-ray [Type] Portable
36644-3   - Chest X-ray [Impression] Portable
8480-5    - Systolic blood pressure systole (first sound)
8462-4    - Diastolic blood pressure systole (second sound)

DOCUMENTOS CLÍNICOS
34108-1   - Outpatient Note
11506-3   - Provider Orders
60591-5   - Patient Summary Note
*/

// ============================================================================
// SNOMED CT: CÓDIGOS CLÍNICOS ADICIONALES
// ============================================================================
/*
SISTEMA: http://snomed.info/sct

REACCIONES ALÉRGICAS
39579001  - Anaphylaxis
4386001   - Bronchospasm
70076002  - Urticaria

HALLAZGOS CARDIOVASCULARES
29315-1   - Chest pain
184310009 - Shortness of breath
17621005  - Normal heart rate

SÍNTOMAS COMUNES
84387000  - Nausea
68962001  - Nausea and vomiting
60845005  - Vomiting
76948002  - Severe headache
*/

// ============================================================================
// VALUE SETS: IDENTIFICADORES Y ESTADOS
// ============================================================================
/*
IDENTIFICADORES PERSONALES (IdentificadoresPersonaVS)
DNI       - Documento Nacional de Identidad
PASAPORTE - Pasaporte
CARNET    - Carnet de conducir
LC        - Libreta Cívica

IDENTIFICADORES PROFESIONALES (IdentificadoresProfesionalVS)
01 - Cédula de Identidad
02 - Cédula de Profesional
03 - Código de Médico del Blanco
04 - Número de Registro Profesional

ESTADO CLÍNICO (clinicalStatus)
active      - The subject of the is currently active
inactive    - The subject is no longer active/alive
recurrence  - The subject is re-experiencing condition after prior resolution
remission   - The subject continues with same condition but in healing/recovery phase
resolved    - The subject is no longer experiencing the condition

ESTADO DE VERIFICACIÓN (verificationStatus)
unconfirmed         - There is not yet enough diagnostic and/or clinical evidence to treat this as a confirmed condition
provisional         - There is enough preliminary diagnostic evidence to suspect that a condition is present (for example, a patient has pneumonia symptoms and a chest x-ray shows infiltrates)
differential        - One of a set of the possible conditions mapped to this problem is the one that best fits the clinical situation
confirmed           - There is sufficient diagnostic and/or clinical evidence to treat this as a confirmed condition
refuted             - The statement was entered in error and is not valid
entered-in-error    - The information was entered in error and the ailment is not valid

ESTADO DE MEDICAMENTO (medicationStatus)
active              - The medication is still being taken
completed           - The medication was taken and the course is completed
entered-in-error    - The entry was made in error and is not valid
intended            - The medication may be taken at some point in the future
stopped             - Actions implied by the statement have been permanently halted, before all of them occurred
on-hold             - Actions implied by the statement have been temporarily halted, but are expected to continue later
unknown             - The authoring system does not know whether the status is active or completed
not-taken           - The medication was not taken

CRITICIDAD DE ALERGIA (criticality)
low                 - The potential clinical impact of a future reaction is estimated as low risk
high                - The potential clinical impact of a future reaction is estimated as high risk
unable-to-assess    - The potential clinical impact of a future reaction is unknown

GÉNERO (gender)
male                - Male
female              - Female
other               - Other
unknown             - Unknown
*/

// ============================================================================
// SISTEMAS COMUNES
// ============================================================================
/*
FHIR INTERNOS:
http://hl7.org/fhir/                    - Sistema base FHIR
http://terminology.hl7.org/CodeSystem/  - CodeSystem FHIR estándar
http://hl7.org/fhir/v2/0203             - Identifier types

INTERNACIONALES:
http://snomed.info/sct                  - SNOMED CT
http://loinc.org                        - LOINC
http://unitsofmeasure.org               - UCUM (unidades de medida)
http://www.iso.org/iso/iso_country_code - ISO 3166-1 alpha-2 (códigos país)

PARAGUAY:
https://mspbs.gov.py/fhir/CodeSystem/IdentificadoresPersona     - DNI, Pasaporte, etc.
https://mspbs.gov.py/fhir/CodeSystem/IdentificadoresProfesional - Cédula médico, etc.
https://mspbs.gov.py/fhir/CodeSystem/Cie10PY                    - CIE-10 Paraguay
*/

// ============================================================================
// EJEMPLOS DE REFERENCIA DE INSTANCIAS
// ============================================================================
/*
PACIENTE BÁSICO:
Reference(Patient/PacientePy-ejemplo-01)
Reference(Patient/4123456)

PROFESIONAL:
Reference(Practitioner/MedicoEjemplo-01)
Reference(Practitioner/1234567)

ORGANIZACIÓN:
Reference(Organization/HospitalCentral-01)
Reference(Organization/HOS-00001)

CONDICIÓN:
Reference(Condition/DiabetesTipo2-01)
Reference(Condition/Diabetes-Ejemplo)

MEDICAMENTO:
Reference(Medication/Metformina-500mg)
Reference(Medication/AAS-100mg)
*/

// ============================================================================
// UNIDADES COMUNES (UCUM)
// ============================================================================
/*
SISTEMA: http://unitsofmeasure.org

MASA/PESO:
g       - Gramo
kg      - Kilogramo
mg      - Miligramo
µg      - Microgramo

VOLUMEN:
mL      - Mililitro
L       - Litro
µL      - Microlitro

CONCENTRACIÓN:
mg/dL   - Miligramo por decilitro
mmol/L  - Milimol por litro
g/dL    - Gramo por decilitro

TEMPERATURA:
Cel     - Grados Celsius
[degF]  - Grados Fahrenheit

PRESIÓN:
mm[Hg]  - Milímetro de mercurio (presión arterial)
kPa     - KiloPascal

TIEMPO:
s       - Segundo
min     - Minuto
h       - Hora
d       - Día
wk      - Semana
mo      - Mes
a       - Año

FRECUENCIA CARDÍACA:
/min    - Por minuto
*/

// ============================================================================
// INTERVALOS NORMALES DE LABORATORIO (REFERENCIA)
// ============================================================================
/*
HEMOGRAMA:
Hemoglobina: 13.5-17.5 g/dL (hombres), 12.0-15.5 g/dL (mujeres)
Hematocrito: 40-54% (hombres), 36-46% (mujeres)
Eritrocitos: 4.5-5.5 millones/µL

GLUCOSA:
Ayunas: 70-100 mg/dL
Random: < 140 mg/dL
HbA1c: < 5.7% (normal), 5.7-6.4% (prediabetes), > 6.5% (diabetes)

PRESIÓN ARTERIAL:
Óptima: < 120/80 mmHg
Elevada: 120-129/<80 mmHg
Etapa 1: 130-139/80-89 mmHg
Etapa 2: ≥ 140/≥ 90 mmHg

PERFIL LIPÍDICO:
Colesterol Total: < 200 mg/dL deseable
LDL: < 100 mg/dL óptimo
HDL: > 40 mg/dL hombres, > 50 mg/dL mujeres
Triglicéridos: < 150 mg/dL

FUNCIÓN RENAL:
Creatinina: 0.6-1.2 mg/dL (hombres), 0.5-1.1 mg/dL (mujeres)
eGFR: > 60 mL/min/m² (normal)

FUNCIÓN HEPÁTICA:
ALT: 7-55 U/L
AST: 10-40 U/L
Bilirrubina total: 0.1-1.2 mg/dL
*/

// ============================================================================
// HORARIOS DE MEDICACIÓN (FRECUENCIA)
// ============================================================================
/*
frequency: 1  period: 1  periodUnit: d  -> Una vez al día
frequency: 2  period: 1  periodUnit: d  -> Dos veces al día
frequency: 3  period: 1  periodUnit: d  -> Tres veces al día
frequency: 4  period: 1  periodUnit: d  -> Cuatro veces al día
frequency: 1  period: 8  periodUnit: h  -> Cada 8 horas
frequency: 1  period: 12 periodUnit: h  -> Cada 12 horas
frequency: 1  period: 1  periodUnit: wk  -> Una vez a la semana
frequency: 2  period: 1  periodUnit: wk  -> Dos veces a la semana
*/

// ============================================================================
// TELÉFONOS DE EJEMPLO: FORMATO
// ============================================================================
/*
PARAGUAY: Código país +595

MÓVILES:
+595981234567  (Tigo/Personal)
+595984567890  (Vox/Claro)
+595971234567  (Copaco)

FIJOS:
+59521234567   (Asunción)
+59572123456   (Ciudad del Este)
+59571234567   (Encarnación)
+59531234567   (Villarrica)
*/

// ============================================================================
// CIUDADES DE PARAGUAY: EJEMPLOS
// ============================================================================
/*
Asunción         - Capital, 525,000 hab
Ciudad del Este  - Itapúa, 308,000 hab
Encarnación      - Misiones, 200,000 hab
Villarrica       - Guairá, 126,000 hab
Caaguazú         - Caaguazú, 125,000 hab
Coronel Oviedo   - Canindeyu, 78,000 hab
Pedro Juan       - Amambay, 75,000 hab
Luque            - Central, 260,000 hab
San Juan Bautista - Misiones, 74,000 hab
Concepción       - Concepción, 65,000 hab
*/

// ============================================================================
// TIPOS DE DOCUMENTOS CLÍNICOS (LOINC)
// ============================================================================
/*
Consulta Externa           34108-1    Outpatient Note
Informe Médico             19005-8    Physician General Clinical Note
Resumen Clínico            60591-5    Patient Summary Note
Historia Clínica           11506-3    Provider Orders
Receta Médica              48767-8    Annotation comment [Interpretation] of Act
Reporte de Laboratorio     24588-7    Electrolyte Panel - Serum or Plasma
Reporte Radiológico        36643-5    Chest X-ray [Type] Portable
Nota de Enfermería         72134-0    Nursing Note
Nota de Anestesia          12028-7    Anesthesia Record
Resumen de Egreso          34799-2    Hospital discharge summary, status post-care
Consulta Psicológica       28635-7    Psychiatric progress note
*/

// ============================================================================
// FORMATOS DE TIMESTAMP
// ============================================================================
/*
ISO 8601 - Estándar FHIR

SOLO FECHA:
2025-01-15          (15 enero 2025)

CON HORA:
2025-01-15T10:30:00Z        (10:30:00 UTC)
2025-01-15T10:30:00+03:00   (10:30:00 hora de Paraguay: UTC-3 en invierno, UTC-4 en verano)

INTERVALO:
startDate: 2025-01-01
endDate: 2025-12-31
*/

// ============================================================================
// BÚSQUEDA DE CÓDIGOS ONLINE
// ============================================================================
/*
CIE-10:     https://icd.who.int/browse10/
LOINC:      https://loinc.org/search/
SNOMED CT:  https://browser.ihtsdotools.org/
UCUM:       https://ucum.nlm.nih.gov/ucum-lhc/demo.html
ISO 3166:   https://www.iso.org/obp/ui/#search
*/

// ============================================================================
// FIN DE REFERENCIA RÁPIDA
// ============================================================================
