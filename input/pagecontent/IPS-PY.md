### **Introducción**

## En esta página, se documenta todos los recursos involucrados para representar la información de un resumen de atención.

### **Perfiles**

En esta sección se describen los perfiles específicos realizados para este contexto de atención.

1️⃣ Perfil de **Bundle Document** Document de RDA:  
[Bundle Document IPS](StructureDefinition-BundleDocPy.html).

---

### **Detalle de Secciones:**

En este apartado se describen las diferentes secciones incluidas en el documento **Compostion**   [Composition](StructureDefinition-CompositionPy.html), para poder representar tanto de antecedendentes del paciente,  asi como detalles de la atención:

2️⃣ Sección que contiene toda la información sobre la medicación actual del paciente:

| **Entrada** | **Link** | **Descripción** |
| --- | --- | --- |
| ✅ **Antecedentes Diagnósiticos** | [Condition](StructureDefinition-ConditionPy.html) | Representa los antecedentedes diagnósticos del paciente. |
| ✅ **Medicación Actual** | [Medication Statement](StructureDefinition-MedicationStatementPy.html). | Representa la información de la medicación actual que toma el paciente. |
| ✅ **Alergias Conocidas** | [Alergias](StructureDefinition-AlergiaPy.html). | Representa las alergias que tiene el paciente. |
| ✅ **Inmunizaciones** | [En proceso --> Inmunizaciones](StructureDefinition-ImmunizationPy.html). | Representa las inmunizaciones que tiene el paciente. |