# Despliegue de la API de la app de pedidos con Terraform

El sistema requiere desplegar la API de una aplicación móvil de pedidos utilizando Terraform. La API será consumida por la aplicación móvil, la cual ya cuenta con una interfaz de usuario preconstruida. El objetivo es aprovisionar la infraestructura necesaria para que la API opere de manera eficiente y segura.

## Informacion General

| Campo | Valor |
|-------|-------|
| **Tema** | Infraestructura como codigo para el backend de una app movil |
| **Nivel** | senior-l2 |
| **Tipo** | practical |
| **Tiempo estimado** | 8 horas |

## Fases del Reto

### Fase 0: Configuración del Proyecto

**Objetivo:** Obtener el proyecto base funcional enviando el Código Base a un asistente de IA, que lo analizará, corregirá errores y entregará cada archivo con su ruta.

**Tiempo estimado:** 15-30 minutos

**Instrucciones:**

- Asegúrate de tener instalado para ejecutar el proyecto: Un IDE o editor de código.
- Copia todo el contenido del campo **Código Base** de este reto — incluyendo el texto de instrucciones que aparece al inicio.
- Abre un asistente de IA (Claude en claude.ai, ChatGPT o Gemini — se recomienda Claude), pega el contenido copiado en el chat y envíalo.
- El asistente analizará los archivos, corregirá errores y entregará cada archivo con su ruta. Guárdalos en la carpeta donde quieras trabajar, respetando las rutas.
- Verifica que el proyecto arranca sin errores.

**Entregable:** El proyecto compila/arranca sin errores.

<details>
<summary>Pistas de conocimiento</summary>

- Copia el Código Base completo incluyendo el texto de instrucciones al inicio — esas instrucciones le indican al asistente exactamente qué hacer con los archivos.
- Si el asistente no entrega todos los archivos al terminar el análisis, escríbele: "entrégame todos los archivos con su ruta".
- Si el proyecto tiene errores al arrancar, comparte el mensaje de error con el mismo asistente para que lo corrija.

</details>

### Fase 1: Configuración inicial de Terraform

**Objetivo:** Configurar el entorno de Terraform para el despliegue de la API.

**Tiempo estimado:** 2 horas

**Instrucciones:**

- Identificar los recursos necesarios para el despliegue de la API.
- Configurar el archivo principal de Terraform con los proveedores y variables necesarias.

**Entregable:** Archivo de configuración de Terraform con proveedores y variables iniciales.

<details>
<summary>Pistas de conocimiento</summary>

- Revisa la documentación de Terraform para configurar los proveedores.
- Utiliza variables para parametrizar la configuración.

</details>

### Fase 2: Definición de recursos de infraestructura

**Objetivo:** Definir los recursos de infraestructura necesarios para el despliegue de la API.

**Tiempo estimado:** 3 horas

**Instrucciones:**

- Definir los recursos de red, almacenamiento y computación necesarios.
- Asegurar que los recursos cumplan con los requisitos de seguridad y rendimiento.

**Entregable:** Archivo de Terraform con la definición de recursos de infraestructura.

<details>
<summary>Pistas de conocimiento</summary>

- Revisa los tipos de recursos disponibles en Terraform para definir la infraestructura.
- Considera los requisitos de seguridad y rendimiento al definir los recursos.

</details>

### Fase 3: Despliegue y validación de la API

**Objetivo:** Desplegar la API y validar su funcionamiento.

**Tiempo estimado:** 3 horas

**Instrucciones:**

- Ejecutar el plan de Terraform para desplegar la API.
- Validar que la API se despliega correctamente y que cumple con los requisitos funcionales.

**Entregable:** API desplegada y validada, lista para ser consumida por la aplicación móvil.

<details>
<summary>Pistas de conocimiento</summary>

- Utiliza el comando `terraform apply` para ejecutar el plan de despliegue.
- Realiza pruebas para validar el funcionamiento de la API.

</details>

## Dimensiones Evaluadas

- **queEs**: ¿Qué es Terraform y cómo se utiliza para el despliegue de infraestructura?
- **paraQueSirve**: ¿Para qué sirve configurar la infraestructura con Terraform en este escenario?
- **comoSeUsa**: ¿Cómo se utiliza Terraform para definir y desplegar recursos de infraestructura?
- **erroresComunes**: ¿Cuáles son los errores comunes al definir recursos de infraestructura con Terraform?
- **queDecisionesImplica**: ¿Qué decisiones implica el despliegue de la API con Terraform en términos de seguridad y rendimiento?

## Criterios de Evaluacion

- Configuración inicial de Terraform con proveedores y variables.
- Definición de recursos de infraestructura necesarios para el despliegue de la API.
- Despliegue y validación exitosa de la API con Terraform.

## Como trabajar con un asistente de IA

Hay dos caminos, elegi uno:

- **AGENTS.md** (recomendado) — instrucciones nativas del repo. Abri esta carpeta con tu agente local (Claude Code, Cursor, Codex, Copilot, Gemini) y las carga solo. Sabe que archivos faltan y con que comando se verifica, y completa el scaffold escribiendo en disco.
- **PROMPT_MEJORA.md** — para copiar y pegar en un chat (claude.ai, ChatGPT) si no tenes un agente en el IDE. Declara lo mismo que AGENTS.md; los archivos que te devuelva el chat los guardas en esta carpeta respetando las rutas.

Ninguno de los dos resuelve las fases del reto: eso es tu trabajo.

## Mapa de componentes

El repo tiene una carpeta por componente. Cada uno se instala y verifica dentro de la suya.

| Componente | Carpeta | Rol | Capa | Track | Tecnologias |
|---|---|---|---|---|---|
| `infra` | `infra/` | practice | infra | Terraform (AWS) | Terraform |
| `client` | `client/` | chapter, support | client | Flutter | Flutter |

## Orden de arranque

1. `cd infra && terraform init -backend=false && terraform -chdir=environments init -backend=false && terraform -chdir=environments/dev init -backend=false && terraform -chdir=environments/prod init -backend=false && terraform -chdir=modules/api_gateway init -backend=false && terraform -chdir=modules/dynamodb init -backend=false && terraform -chdir=modules/lambda init -backend=false && terraform -chdir=modules/vpc init -backend=false && terraform validate && terraform -chdir=environments validate && terraform -chdir=environments/dev validate && terraform -chdir=environments/prod validate && terraform -chdir=modules/api_gateway validate && terraform -chdir=modules/dynamodb validate && terraform -chdir=modules/lambda validate && terraform -chdir=modules/vpc validate` — componente `infra` (practice).
2. `cd client && flutter pub get && flutter analyze` — componente `client` (chapter, support).

### Contratos entre componentes

- `infra` expone http (api: https://${aws_api_gateway_rest_api.id}.execute-api.${var.region}.amazonaws.com):
  - `POST /orders`
  - `GET /orders/{id}`
  - `PUT /orders/{id}`
  - `DELETE /orders/{id}`

## Verificacion

El proyecto esta listo para trabajar cuando este comando corre sin errores:

```bash
(cd infra && terraform init -backend=false && terraform -chdir=environments init -backend=false && terraform -chdir=environments/dev init -backend=false && terraform -chdir=environments/prod init -backend=false && terraform -chdir=modules/api_gateway init -backend=false && terraform -chdir=modules/dynamodb init -backend=false && terraform -chdir=modules/lambda init -backend=false && terraform -chdir=modules/vpc init -backend=false && terraform validate && terraform -chdir=environments validate && terraform -chdir=environments/dev validate && terraform -chdir=environments/prod validate && terraform -chdir=modules/api_gateway validate && terraform -chdir=modules/dynamodb validate && terraform -chdir=modules/lambda validate && terraform -chdir=modules/vpc validate) && (cd client && flutter pub get && flutter analyze)
```

---

*Reto generado automaticamente por Challenge Generator - Pragma*
