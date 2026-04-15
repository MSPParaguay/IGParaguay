# Generador de Ejemplos FSH - IPS Paraguay

## 🚀 Inicio Rápido

Esta **Skill** genera ejemplos FSH válidos para cada perfil de la Guía de Implementación FHIR de Paraguay.

### Uso Básico

En VS Code, abre el Chat de Copilot y escribe:

```
/generador-ejemplos-fsh
```

Luego especifica:
- **Perfil**: ¿Para cuál perfil quieres ejemplo?
- **Contexto**: ¿Qué tipo de paciente o escenario?
- **Idioma**: Español (por defecto)

### Ejemplos de Solicitud

**Generar ejemplo del Paciente:**
```
/generador-ejemplos-fsh
Genera un ejemplo FSH para el perfil PacientePy
Paciente: adulto, diabético, de Asunción
```

**Generar múltiples:**
```
/generador-ejemplos-fsh
Genera ejemplos para: PacientePy, ConditionPy, MedicationStatementPy
Caso: paciente con diabetes tipo 2 en tratamiento farmacológico
```

**Validad un ejemplo:**
```
/generador-ejemplos-fsh
Valida este FSH:
[pega tu código FSH]
```

---

## 📋 Perfiles Disponibles

| Perfil | Descripción | Campos Clave |
|--------|-------------|--------------|
| **PacientePy** | Datos demográficos y personal | ID, nombre, sexo, fecha nac. |
| **PractitionerPy** | Profesionales sanitarios | ID, nombre, especialidad, contacto |
| **OrganizacionPy** | Instituciones de salud | ID, nombre, tipo, dirección |
| **ConditionPy** | Diagnósticos (CIE-10) | código, paciente, estado clínico |
| **MedicationStatementPy** | Medicamentos activos | código, dosis, frecuencia |
| **AlergiaPy** | Alergias e intolerancias | alérgeno, reacción, criticidad |
| **CompositionPy** | Documentos clínicos | tipo, secciones, fecha |
| **BundleDocPy** | Bundles de documentos | Composition + recursos |
| **DocumentReferencePy** | Referencias a documentos | URL, tipo, fecha |
| **ListPy** | Listas clínicas | título, modo, entradas |
| **BundleTransaccPy** | Bundles de transacción | operaciones batch |

---

## 🔧 Estructura de Ejemplo

Todos los ejemplos siguen este patrón:

```fsh
Instance: [NombreInstancia]
InstanceOf: [NombrePerfil]
Usage: #example
Description: "[Descripción en español]"

* [elemento] = [valor]
* [elemento].coding.system = "[sistema]"
* [elemento].coding.code = #[código]
```

---

## 📚 Archivos de Referencia

### Plantillas (`plantillas-ejemplos.fsh`)
- 11 plantillas base para cada perfil
- Snippets reutilizables
- Códigos CIE-10 comunes

### SKILL.md (esta documentación)
- Instrucciones detalladas por perfil
- Ejemplos completos y funcionales
- Mejores prácticas
- Restricciones y validación

---

## ✅ Validación

El generador valida automáticamente:

- ✓ Sintaxis FSH correcta
- ✓ Tipos de datos (string, Reference, Coding, etc.)
- ✓ Cardinalidad (1.., 0..1, 1..1)
- ✓ Códigos contra Value Sets
- ✓ Referencias válidas
- ✓ Timestamps en ISO 8601

---

## 🇵🇾 Convenciones Paraguay

El generador usa:

- **Moneda**: Guaraní (₲)
- **Teléfono**: +595 (código país)
- **Ciudades**: Asunción, Ciudad del Este, Encarnación, etc.
- **Idioma**: Español (descripciones y notas)
- **Códigos**: CIE-10 para diagnósticos, LOINC para pruebas
- **Organizaciones**: Hospital, Centro de Salud, Clínica

---

## 🆘 Troubleshooting

### Problema: "No reconoce el perfil"
**Solución**: Verifica que el nombre del perfil sea exacto (ej: `PacientePy`, no `Paciente`)

### Problema: "Código CIE-10 inválido"
**Solución**: Usa códigos válidos (ej: `E11` para diabetes tipo 2, `I10` para hipertensión)

### Problema: "La referencia no existe"
**Solución**: Asegúrate que la instancia referenciada esté definida o usa `Reference(Patient/ejemplo-id)`

### Problema: "Error de sintaxis en el FSH"
**Solución**: 
- Verifica puntos finales en cada línea
- No uses espacios en códigos
- Escapa caracteres especiales en strings

---

## 📖 Uso Avanzado

### Con Variables Personalizadas

```
/generador-ejemplos-fsh
Perfil: ConditionPy
Diagnóstico: Diabetes tipo 2
Complicaciones: nefropatía diabética
Códigos CIE-10: E11.2 (con complicaciones renales)
Estado: confirmada
```

### Generar Secuencia Completa

```
/generador-ejemplos-fsh
Caso: paciente completo con historia clínica

Recursos necesarios:
1. PacientePy - María González
2. PractitionerPy - Dr. Pérez
3. OrganizacionPy - Hospital Central
4. ConditionPy - Diabetes
5. MedicationStatementPy - Metformina
6. CompositionPy - Consulta
7. BundleDocPy - Documento completo
```

### Validar y Mejorar

```
/generador-ejemplos-fsh
Valida y mejora este FSH:
[pega tu código]

Mejoramientos sugeridos:
- Optimizar cardinalidad
- Agregar campos opcionales
- Mejorar descripciones
```

---

## 🎯 Casos de Uso

1. **Desarrollo**: Crear ejemplos para testing
2. **Documentación**: Generar ejemplos para guías
3. **Validación**: Verificar perfiles funcionan correctamente
4. **Capacitación**: Mostrar cómo usar cada perfil
5. **Migración**: Convertir datos a formato FHIR

---

## 📝 Notas

- El generador no modifica perfiles existentes
- No elimina ejemplos previos
- Genera archivos en `input/fsh/examples/`
- Todos los ejemplos son ficticios y anonimizados
- Compatible con GNU FHIR Tooling (GoFSH)

---

## 🔗 Referencias

- [Sitio Oficial FHIR](https://www.hl7.org/fhir/)
- [Documentación FSH](https://fshschool.org/)
- [CIE-10 Online](https://icd.who.int/browse10/)
- [LOINC](https://loinc.org/)
- [SNOMED CT](https://www.snomed.org/)

---

## 💡 Tips Prácticos

### CIE-10 Comunes en Paraguay

```
E11    - Diabetes tipo 2
I10    - Hipertensión esencial
J18    - Neumonía
K29    - Gastritis
A18.8  - Tuberculosis
```

### Identidades de Prueba

```
Paciente: 4123456 (ficticio)
Profesional: 1234567 (ficticio)
Organización: HOS-00001 (ficticio)
```

### Teléfonos de Ejemplo

```
+595981234567  (móvil)
+59521234567   (fijo)
```

### Ciudades de Referencia

```
Asunción (capital)
Ciudad del Este (Itapúa)
Encarnación (Misiones)
Villarrica (Guairá)
```

---

**Versión**: 1.0  
**Última actualización**: 15 abril 2026  
**Mantenedor**: Team FHIR Paraguay
