## **Antecedentes**

La Historia Clínica Electrónica Interoperable (HCEI) en Paraguay forma parte del fortalecimiento del Sistema Nacional de Información en Salud (SINAIS), cuyo objetivo es apoyar la continuidad asistencial de los pacientes y garantizar el acceso oportuno a información clínica relevante entre los distintos niveles de atención y prestadores de servicios de salud.

  
El marco de referencia se fundamenta en:

*   La política nacional de interoperabilidad en salud definida por el Ministerio de Salud Pública y Bienestar Social (MSPBS).
*   Las acciones impulsadas en el marco de la cooperación internacional, en especial el Proyecto HIS de Taiwán, que ha permitido el desarrollo de módulos funcionales y la capacitación en sistemas de información.
*   La adopción de estándares internacionales para garantizar la armonización con iniciativas regionales, entre ellas el Proyecto LACPASS liderado por la OPS, que promueve el uso del International Patient Summary (IPS) como estándar común en la región.

El IPS (International Patient Summary), definido en la ISO 27269:2021, se adopta en Paraguay como el **RDA (Resumen Digital en Atención)** documento mínimo de intercambio clínico, garantizando que la información esencial de un paciente pueda compartirse de manera estructurada y segura, tanto en situaciones de atención rutinaria como de emergencia.

## **Alcances**

La presente **Guía de Implementación (GI)** define la especificación técnica para la **interoperabilidad de datos clínicos relevantes en Paraguay** bajo el estándar **FHIR R4**.

Los focos principales son:

*   **Datos demográficos:** Información de pacientes, profesionales y organizaciones
*   **Resumen Digital en Atención (RDA):** Documento mínimo de intercambio clínico basado en ISO 27269:2021 (International Patient Summary)
*   **Información clínica:** Diagnósticos, medicamentos, alergias e inmunizaciones con terminologías estandarizadas
*   **Terminología e interoperabilidad:** Uso de estándares internacionales (SNOMED CT, CIE-10, LOINC) adaptados para Paraguay
*   **Operaciones y transacciones FHIR:** Intercambio de documentos conforme a IHE MHD (ITI-65, ITI-67, ITI-68)

Esta guía detalla las interacciones requeridas entre prestadores de salud y plataformas nacionales de interoperabilidad para:

*   **Envío (ITI-65):** Registrar y enviar documentos clínicos (Provide and Register DocumentReference transaction)
*   **Búsqueda (ITI-67):** Consultar índices de documentos por paciente (Find DocumentReferences transaction)
*   **Recuperación (ITI-68):** Obtener documentos completos y sus recursos asociados (Retrieve Document Set transaction)

## **Cómo leer esta Guía**

Esta Guía sigue un formato especificado para **FHIR R4**, con énfasis en la adopción del **Resumen Digital en Atención (RDA)** como documento mínimo de intercambio clínico. Se divide en varias secciones navegables que proporcionan:

1. **Descripción conceptual:** Introducción, contexto y referencias normativas
2. **Especificaciones técnicas:** Detalles de cada perfil FHIR definido
3. **Implementación:** Operaciones, transacciones y ejemplos funcionales
4. **Recursos:** Vocabularios, terminologías y materiales de referencia

El **menú de navegación** en la parte superior organiza el contenido de manera jerárquica para facilitar la navegación según el rol del implementador.

### **Secciones principales**

*   **Home:** Proporciona la introducción y el contexto general de esta Guía.
*   **Perfiles Base:** Describen los perfiles sobre los datos básicos codificados generados para Paraguay. Incluyen recursos fundamentales como Paciente, Organización, Profesional de Salud, Identificadores, Contactos, entre otros.
*   **Perfiles de Información Clínica:** Incluyen los perfiles especializados para representar información de salud del paciente, como problemas de salud, alergias, medicamentos e inmunizaciones. Su objetivo es garantizar que los datos clínicos relevantes se compartan de manera estructurada, interoperable y con semántica estandarizada mediante terminologías internacionales.
*   **Perfiles de Documentos:** definen la manera en que se agrupa y estructura la información clínica y administrativa en Paraguay, de acuerdo con los estándares FHIR R4 y RDA. Estos perfiles aseguran que los datos clínicos relevantes puedan ser compartidos como unidades completas e independientes de información, útiles para continuidad asistencial, referencia, contrarreferencia y salud pública.
*   **Transacciones:** Definen las operaciones técnicas necesarias para el intercambio de los artefactos FHIR entre sistemas, conforme al estándar IHE MHD.
*   **Terminología:** Describe los vocabularios y sistemas de codificación utilizados en la guía, incluyendo CIE-10 adaptada para Paraguay.
*   **Resumen:** Proporciona información técnica adicional, especificaciones y recursos de descarga.

### **Destinatarios**

Esta guía está dirigida a:

*   Prestadores de servicios de salud públicos y privados.
*   Proveedores de software en el sector salud paraguayo.
*   Instituciones gubernamentales que apoyan la adopción de la interoperabilidad de la HCEI.
*   Organismos internacionales y de cooperación técnica vinculados al fortalecimiento del SINAIS.

## **Colaboradores**

El proyecto es desarrollado por el Ministerio de Salud Pública y Bienestar Social de Paraguay (MSPBS), con el apoyo de:

*   Banco Interamericano de Desarrollo (BID).
*   Organización Panamericana de la Salud (OPS).