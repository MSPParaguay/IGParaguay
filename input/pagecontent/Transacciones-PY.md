### **Introducción**

_En esta página, se documenta todos los recursos involucrados para representar la información de un resumen de atención._

### **Perfiles**

_En esta sección se describen los perfiles específicos realizados para este contexto de atención._

1️⃣ GUARDAR Registro de Atención - **Perfil MDH - ITI 65**

`POST <Base del Servidor>`

*   Para registrar un documento IPS, se debe enviar una transacción con los siguientes recursos: 
    *   LIST --> [link](StructureDefinition-ListPy.html). 
    *   DOCUMENT REFERENCE --> [link](StructureDefinition-DocumentReferencePy.html).
    *   BUNDLE-Document --> [link](StructureDefinition-BundlePy.html).
    *   PATIENT  --> [link](StructureDefinition-PacientePy.html).

2️⃣ BUSCAR Atenciones de un paciente:  **Perfil MDH - ITI 67**

`GET <Base del Servidor>/DocumentReference?patient=1234`

3️⃣ DESPLEGAR Atenciones de un paciente:  **Perfil MDH - ITI 68**

`GET <Base del Servidor>/Bundle/ID`

---

