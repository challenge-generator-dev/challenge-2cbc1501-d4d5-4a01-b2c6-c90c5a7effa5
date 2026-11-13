# Prompt para Mejorar el Codigo Base

Copia y pega el contenido del bloque de abajo en un asistente de IA (Claude, ChatGPT)
para obtener el proyecto completo y arrancable. Guarda los archivos que te devuelva en la
carpeta del repo, respetando exactamente las rutas.

Si preferis trabajar en tu editor con un agente local (Claude Code, Cursor, Copilot), usa `AGENTS.md` en vez de este archivo: dice lo mismo pero para que escriba los archivos en disco.

## Las dos reglas que no se negocian

1. **Completa el boilerplate.** Todo lo que el proyecto necesita para compilar y arrancar: manifiesto de dependencias, punto de entrada, configuracion, capa de interfaz, y las capas del patron arquitectonico declarado. Eso es andamiaje y es tu trabajo.
2. **NO resuelvas el reto.** Los entregables de las fases son el trabajo de la persona. El hueco pedagogico se deja como esta: el proyecto arranca, pero lo que el reto pide implementar NO esta implementado.

Dicho de otra forma: si algo impide compilar, arreglalo. Si algo es logica de negocio incompleta, validaciones ausentes, un secreto hardcodeado o un patron mejorable, dejalo exactamente como esta — es lo que la persona tiene que encontrar.

## Superficie de practica — NO resuelvas

Estos archivos SON el ejercicio de la persona. No los implementes; deja stubs.

- `infra/modules/api_gateway/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/api_gateway/outputs.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/lambda/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/lambda/outputs.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/dynamodb/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/dynamodb/outputs.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/vpc/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/vpc/outputs.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/environments/dev/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/environments/prod/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.

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

## Lo que le falta a este proyecto

Esto NO lo tenes que adivinar: salio de comparar el proyecto contra la arquitectura declarada del reto y de un analisis estatico del codigo. Completalo TODO.

### Referencias colgando en el codigo que si esta

Cada una rompe la compilacion:

- `client/lib/data/sources/order_api_client.dart` — `Order.toJson`: Se invoca `toJson` sobre `Order`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- `client/lib/data/repositories/order_repository_impl.dart` — `Order.copyWith`: Se invoca `copyWith` sobre `Order`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.

### Referencias no verificadas

Referencias no verificadas para: .dart. El analisis estatico no cubre esos lenguajes: que no se haya listado nada NO garantiza que no haya referencias colgando.

## Como saber que terminaste

```bash
(cd infra && terraform init -backend=false && terraform -chdir=environments init -backend=false && terraform -chdir=environments/dev init -backend=false && terraform -chdir=environments/prod init -backend=false && terraform -chdir=modules/api_gateway init -backend=false && terraform -chdir=modules/dynamodb init -backend=false && terraform -chdir=modules/lambda init -backend=false && terraform -chdir=modules/vpc init -backend=false && terraform validate && terraform -chdir=environments validate && terraform -chdir=environments/dev validate && terraform -chdir=environments/prod validate && terraform -chdir=modules/api_gateway validate && terraform -chdir=modules/dynamodb validate && terraform -chdir=modules/lambda validate && terraform -chdir=modules/vpc validate) && (cd client && flutter pub get && flutter analyze)
```

Ese comando corriendo sin errores es la definicion de "listo".

---

```
## Briefing del reto (autoridad)
Este bloque manda sobre los archivos adjuntos. El stack y el rol salen de AQUÍ, no de un topic genérico ni de markdown placeholder.

### Perfil
Chapter Movil, Especialidad Desarrollador, Tecnología Flutter, Senior L2

### Brecha de conocimiento
Aprovisionar infraestructura con Terraform para la app movil, Aprovisiona con Terraform los recursos que consume la aplicacion movil

### Misión / candidato
Desplegar la API de la app de pedidos

### Reto
- Tema: Infraestructura como codigo para el backend de una app movil
- Seniority: senior-l2
- Tipo: practical
- Título: Despliegue de la API de la app de pedidos con Terraform
- Tiempo estimado: 8 horas

### Fases (trabajo del HUMANO — PROHIBIDO completarlas)
No implementes estos entregables. Dejalos como hueco pedagógico. El asistente solo materializa el proyecto arrancable para que el participante pueda trabajar.
- Fase 1: Configuración inicial de Terraform — objetivo: Configurar el entorno de Terraform para el despliegue de la API. — entregable (NO resolver): Archivo de configuración de Terraform con proveedores y variables iniciales.
- Fase 2: Definición de recursos de infraestructura — objetivo: Definir los recursos de infraestructura necesarios para el despliegue de la API. — entregable (NO resolver): Archivo de Terraform con la definición de recursos de infraestructura.
- Fase 3: Despliegue y validación de la API — objetivo: Desplegar la API y validar su funcionamiento. — entregable (NO resolver): API desplegada y validada, lista para ser consumida por la aplicación móvil.

Eres un asistente experto en análisis, corrección y generación de archivos de cualquier tipo:
código fuente, documentación, hojas de cálculo, documentos Word, configuraciones, entre otros.
Voy a enviarte una cadena de texto que contiene uno o más archivos. Cada archivo está delimitado por un marcador con el siguiente formato:
// === ARCHIVO: ruta/del/archivo.extension ===
o también puede aparecer como:
## === ARCHIVO: ruta/del/archivo.extension ===
Lo que sigue al marcador puede ser:

El contenido real del archivo (código, texto, YAML, etc.)
Una descripción en lenguaje natural de lo que debe contener el archivo


TU TAREA
PASO 0 — ¿Esto es un proyecto o una carcasa?
Antes de extraer archivos, leé el Briefing (si está) y diagnosticá el adjunto.

Es CARCASA si ocurre CUALQUIERA de estas:
- No hay manifiesto de dependencias del stack del briefing (manifest.json de VTEX IO / package.json / pom.xml / build.gradle / requirements.txt / go.mod / *.tf / *.csproj, según corresponda)
- Hay un "binario" que en realidad es un comentario ("no puede ser mostrado como texto plano", placeholder .fig/.docx vacío)
- Los markdowns ya completan entregables de fases posteriores ("se implementó fade-in", lista de áreas ya resuelta)

Si es CARCASA:
- MATERIALIZÁ un proyecto que arranca en el stack del briefing (VTEX IO Store Framework, Angular, Terraform, pytest, Nest, etc.). Incluí manifiesto, punto de entrada y capa de interfaz reales.
- NO copies los markdowns de "solución" como si fueran el producto. Son ruido de generación.
- NO resuelvas las fases del briefing (están marcadas PROHIBIDO). Dejá el hueco pedagógico: el flujo existe, las microinteracciones/calidad/infra que el reto pide NO están hechas.
- Después seguí al PASO 5 (entrega de archivos).

Si es un proyecto REAL (manifiesto + código que compila o arranca):
- Seguí PASO 1 en adelante. 🔴 compilación sí. 🟡 pedagógico no.

PASO 1 — Detección y extracción
Identifica todos los archivos presentes en la cadena. Para cada archivo extrae:

Su ruta completa (ej: src/main/java/com/pragma/Service.java)
Su contenido o descripción

PASO 2 — Clasificación por tipo
Clasifica cada archivo en una de estas categorías:
A) Código fuente (Java, Python, TypeScript, JavaScript, Kotlin, etc.)
B) Configuración / documentación (YAML, properties, Markdown, JSON, txt, etc.)
C) Excel (.xlsx, .xls, .csv)
D) Word (.docx, .doc)
E) Otro tipo de archivo binario o especial
PASO 3 — Clasificación de errores en código fuente

Objetivo prioritario: que el proyecto compile. No corrijas flujo de negocio ni lógica funcional.

Antes de modificar cualquier archivo de código fuente, clasifica cada problema encontrado en una de estas dos categorías:
🔴 ERROR DE COMPILACIÓN — corregir siempre
Son errores que impiden que el proyecto arranque, sin valor pedagógico:

Import faltante o incorrecto
Clase, método o variable referenciada que no existe en ningún archivo del proyecto
Error de sintaxis
Anotación con atributos inválidos
Dependencia ausente en pom.xml, package.json, etc.
Archivo referenciado que no existe y debe ser creado con implementación mínima

→ CORREGIR estos errores.
🟡 PROBLEMA FUNCIONAL O DE CALIDAD — preservar siempre
Son problemas que no impiden compilar. Pueden ser intencionales para el aprendizaje:

Clave secreta hardcodeada ("secret", "password123")
API deprecada que funciona pero tiene reemplazo moderno
Lógica de negocio incorrecta o incompleta
Código redundante o de baja legibilidad
Falta de validaciones en flujo de negocio
Patrones de diseño incorrectos pero funcionales
Concurrencia no segura
Configuración funcional pero no óptima

→ PRESERVAR tal cual. No corregir, no mejorar, no comentar.
PASO 4 — Procesamiento según tipo de archivo
Tipo A — Código fuente
Aplica únicamente las correcciones clasificadas como 🔴 ERROR DE COMPILACIÓN.
No alteres ningún elemento clasificado como 🟡 PROBLEMA FUNCIONAL O DE CALIDAD.
Si falta un archivo referenciado, créalo con la implementación mínima necesaria para compilar.
Tipo B — Configuración / documentación
Extrae el contenido tal cual, sin modificaciones salvo errores evidentes de sintaxis
(ej: YAML mal indentado).
Tipo C — Excel (.xlsx)
Si viene con contenido real, genera el archivo respetando ese contenido.
Si viene con descripción en lenguaje natural, genera un archivo Excel funcional con:

Fila de encabezados en negrita con color de fondo distintivo
Columnas con ancho ajustado al contenido
Tipos de dato correctos por columna
Validaciones si la descripción lo indica
Hojas nombradas descriptivamente si hay más de una
Filas de ejemplo si no hay datos reales

Tipo D — Word (.docx)
Si viene con contenido real, genera el archivo respetando ese contenido.
Si viene con descripción en lenguaje natural, genera un documento Word funcional con:

Estilos de título (Título 1, Título 2) para jerarquía de secciones
Fuente legible (Calibri o equivalente), tamaño 11-12pt para cuerpo
Márgenes estándar
Tabla de contenido si tiene múltiples secciones
Tablas con encabezados en negrita si aplica

Tipo E — Otro
Genera el archivo con el contenido o estructura más apropiada según la descripción.
PASO 5 — Entrega de archivos
Entregá cada archivo con su ruta completa, respetando exactamente la estructura de rutas
indicada por los marcadores: un bloque por archivo, precedido por su ruta. No generes ZIPs
ni archivos adjuntos.
La entrega debe incluir:

Archivos de código con únicamente los errores de compilación corregidos
Archivos de configuración y documentación sin cambios
Archivos nuevos creados para resolver dependencias de compilación faltantes
Archivos Excel y Word generados desde descripción

IMPORTANTE: Entregá los archivos completos al finalizar. No preguntes si el usuario
quiere recibirlos. Simplemente entregalos; No debes desplegar en el chat el resumen de lo que arreglaste, solo entregá los archivos.

REGLAS IMPORTANTES

No omitas ningún archivo aunque no tenga errores ni modificaciones
Respeta los nombres y rutas exactas indicadas por los marcadores
Si un archivo no tiene marcador claro, infiere el nombre desde su contenido
Si la cadena contiene solo documentación, placeholders o binarios fake, NO la reproduzcas:
aplicá PASO 0 (materializar el proyecto del briefing). Reproducir la carcasa es un fallo.
No agregues texto después del último archivo entregado
No preguntes si el usuario quiere los archivos: simplemente entregalos siempre
Si detectas que falta un archivo de configuración necesario para compilar
(pom.xml, package.json, requirements.txt, build.gradle, etc.), créalo e inclúyelo
inferiendo su contenido desde los imports y frameworks detectados en el código
Nunca corrijas problemas 🟡 aunque parezcan obvios o fáciles de mejorar.
El participante que recibirá este proyecto los debe encontrar y resolver él mismo.


INPUT
Aquí está la cadena con los archivos:

// === ARCHIVO: infra/README.md ===
# Terraform Infrastructure for API Gateway, Lambda, and DynamoDB

## Project Structure

```
.
├── environments/
│   ├── dev/
│   │   ├── backend.tf
│   │   ├── main.tf
│   │   └── terraform.tfvars
│   ├── prod/
│   │   ├── backend.tf
│   │   └── main.tf
│   ├── outputs.tf
│   └── variables.tf
├── modules/
│   ├── api_gateway/
│   │   ├── main.tf
│   │   └── outputs.tf
│   ├── dynamodb/
│   │   ├── main.tf
│   │   └── outputs.tf
│   ├── lambda/
│   │   ├── main.tf
│   │   └── outputs.tf
│   └── vpc/
│       ├── main.tf
│       └── outputs.tf
├── providers.tf
├── versions.tf
└── README.md
```

## Prerequisites

1. **Terraform** >= 1.9.0 installed
2. **AWS CLI** configured with proper credentials (`aws configure`)
3. **AWS Account** with permissions to create:
   - API Gateway
   - Lambda functions
   - DynamoDB tables
   - VPC resources

## Setup Instructions

### Initialize Terraform

```bash
cd environments/dev
terraform init
```

### Review and Plan

```bash
terraform plan
```

### Apply Changes

```bash
terraform apply
```

## Environment Configuration

- **Development**: `environments/dev/`
- **Production**: `environments/prod/`

Each environment has its own:
- `backend.tf` (remote state configuration)
- `main.tf` (module instantiation)
- `terraform.tfvars` (environment-specific variables, dev only)

## Modules Overview

| Module       | Purpose                                                                 |
|--------------|-------------------------------------------------------------------------|
| `api_gateway`| Creates REST API Gateway with routes and integrations                  |
| `lambda`     | Deploys Lambda functions with proper IAM roles and permissions         |
| `dynamodb`   | Creates DynamoDB tables with appropriate capacity settings             |
| `vpc`        | Sets up VPC, subnets, security groups, and networking requirements     |

## Outputs

After applying, Terraform will output:
- API Gateway endpoint URL
- Lambda function ARNs
- DynamoDB table names
- VPC configuration details

## Validation

To verify the infrastructure:
```bash
terraform output
```

For a specific environment:
```bash
cd environments/dev
terraform output
```

// === ARCHIVO: infra/environments/dev/terraform.tfvars ===
# Terraform tfvars for dev environment
# AWS Region
aws_region = "us-east-1"

# VPC Configuration
vpc_cidr_block = "10.0.0.0/16"
public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]

# DynamoDB Configuration
dynamodb_table_name = "dev-table"
dynamodb_billing_mode = "PAY_PER_REQUEST"
dynamodb_hash_key = "id"

# Lambda Configuration
lambda_function_name = "dev-lambda-function"
lambda_runtime = "nodejs20.x"
lambda_handler = "index.handler"
lambda_memory_size = 128
lambda_timeout = 3

# API Gateway Configuration
api_gateway_name = "dev-api-gateway"
api_gateway_protocol_type = "HTTP"

// === ARCHIVO: infra/versions.tf ===
terraform {
  required_version = ">= 1.9.0, < 2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "= 5.100.0"
    }
  }
}

// === ARCHIVO: infra/providers.tf ===
provider "aws" {
  region = "us-east-1"
}

// === ARCHIVO: infra/environments/variables.tf ===
# Variables globales para la infraestructura de la API de pedidos
# Estas variables se usan en todos los entornos (dev/prod)

variable "region" {
  description = "Región de AWS donde se desplegará la infraestructura"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Entorno de despliegue (dev/prod)"
  type        = string
}

variable "project_name" {
  description = "Nombre del proyecto para etiquetar recursos"
  type        = string
  default     = "mobile-order-api"
}

variable "lambda_runtime" {
  description = "Runtime para las funciones Lambda"
  type        = string
  default     = "nodejs20.x"
}

variable "lambda_handler" {
  description = "Handler para las funciones Lambda"
  type        = string
  default     = "index.handler"
}

variable "dynamodb_read_capacity" {
  description = "Capacidad de lectura para DynamoDB"
  type        = number
  default     = 5
}

variable "dynamodb_write_capacity" {
  description = "Capacidad de escritura para DynamoDB"
  type        = number
  default     = 5
}

variable "api_gateway_stage_name" {
  description = "Nombre del stage para API Gateway"
  type        = string
  default     = "v1"
}

variable "vpc_cidr" {
  description = "Bloque CIDR para la VPC donde se desplegarán los recursos"
  type        = string
  default     = "10.0.0.0/16"
}

// === ARCHIVO: infra/modules/api_gateway/main.tf ===
# TODO(reto): Define los recursos de API Gateway para la API de pedidos
# Debes crear:
# 1. aws_api_gateway_rest_api con nombre "${var.project_name}-api"
# 2. aws_api_gateway_resource para "/orders"
# 3. aws_api_gateway_resource para "/orders/{id}"
# 4. aws_api_gateway_method para cada endpoint (POST, GET, PUT, DELETE)
# 5. aws_api_gateway_integration para cada método, integrando con Lambda
# 6. aws_api_gateway_deployment para desplegar la API
# 7. aws_api_gateway_stage para el stage "${var.api_gateway_stage_name}"
# 8. aws_lambda_permission para permitir que API Gateway invoque las Lambdas

variable "project_name" {
  description = "Nombre del proyecto para etiquetar recursos"
  type        = string
}

variable "api_gateway_stage_name" {
  description = "Nombre del stage para API Gateway"
  type        = string
}

variable "lambda_invoke_arn" {
  description = "ARN de la función Lambda para integración"
  type        = string
}

variable "lambda_function_name" {
  description = "Nombre de la función Lambda para permisos"
  type        = string
}

# TODO(reto): Implementar recursos de API Gateway aquí

// === ARCHIVO: infra/modules/api_gateway/outputs.tf ===
# TODO(reto): Exporta los outputs necesarios para integrar API Gateway con otros módulos
# Debes exportar:
# 1. El ID de la API Gateway (aws_api_gateway_rest_api.id)
# 2. El ARN de ejecución de la API (aws_api_gateway_rest_api.execution_arn)
# 3. La URL de invocación de la API (aws_api_gateway_deployment.invoke_url)

output "api_gateway_id" {
  description = "ID de la API Gateway"
  value       = "" # TODO(reto): Asignar valor
}

output "api_gateway_execution_arn" {
  description = "ARN de ejecución de la API Gateway"
  value       = "" # TODO(reto): Asignar valor
}

output "api_gateway_invoke_url" {
  description = "URL de invocación de la API Gateway"
  value       = "" # TODO(reto): Asignar valor
}

// === ARCHIVO: infra/modules/lambda/main.tf ===
# TODO(reto): Define los recursos de Lambda para la API de pedidos
# Debes crear:
# 1. aws_lambda_function para manejar las operaciones de pedidos
# 2. aws_iam_role para la función Lambda con permisos mínimos
# 3. aws_iam_role_policy_attachment para adjuntar políticas a la función
# 4. aws_cloudwatch_log_group para logs de la función

variable "project_name" {
  description = "Nombre del proyecto para etiquetar recursos"
  type        = string
}

variable "environment" {
  description = "Entorno de despliegue (dev/prod)"
  type        = string
}

variable "lambda_runtime" {
  description = "Runtime para la función Lambda"
  type        = string
}

variable "lambda_handler" {
  description = "Handler para la función Lambda"
  type        = string
}

variable "dynamodb_table_arn" {
  description = "ARN de la tabla DynamoDB para permisos"
  type        = string
}

variable "vpc_security_group_ids" {
  description = "IDs de los security groups para la Lambda"
  type        = list(string)
}

variable "vpc_subnet_ids" {
  description = "IDs de las subnets para la Lambda"
  type        = list(string)
}

# TODO(reto): Implementar recursos de Lambda aquí

// === ARCHIVO: infra/modules/dynamodb/main.tf ===
# TODO(reto): Define los recursos de DynamoDB para la API de pedidos
# Debes crear:
# 1. aws_dynamodb_table para almacenar pedidos con:
#    - Clave primaria: order_id (string)
#    - Índice secundario global para user_id (si es necesario)
#    - Capacidades de lectura/escritura configurables
# 2. Etiquetas con project_name y environment

variable "project_name" {
  description = "Nombre del proyecto para etiquetar recursos"
  type        = string
}

variable "environment" {
  description = "Entorno de despliegue (dev/prod)"
  type        = string
}

variable "read_capacity" {
  description = "Capacidad de lectura para DynamoDB"
  type        = number
}

variable "write_capacity" {
  description = "Capacidad de escritura para DynamoDB"
  type        = number
}

# TODO(reto): Implementar recursos de DynamoDB aquí

// === ARCHIVO: infra/modules/vpc/main.tf ===
# TODO(reto): Define los recursos de VPC para la API de pedidos
# Debes crear:
# 1. aws_vpc con CIDR block adecuado
# 2. aws_subnet para subredes públicas y privadas
# 3. aws_internet_gateway para acceso a internet
# 4. aws_route_table y aws_route_table_association para routing
# 5. aws_security_group para controlar el tráfico a Lambda y DynamoDB
# 6. aws_vpc_endpoint para DynamoDB (opcional para mejor seguridad)

variable "project_name" {
  description = "Nombre del proyecto para etiquetar recursos"
  type        = string
}

variable "environment" {
  description = "Entorno de despliegue (dev/prod)"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block para la VPC"
  type        = string
  default     = "10.0.0.0/16"
}

# TODO(reto): Implementar recursos de VPC aquí

// === ARCHIVO: infra/modules/lambda/outputs.tf ===
# Outputs del módulo Lambda
# Superficie de práctica: el estudiante debe implementar los outputs correctos

output "function_name" {
  description = "TODO(reto)"
  value       = aws_lambda_function.this.function_name
}

output "arn" {
  description = "TODO(reto)"
  value       = aws_lambda_function.this.arn
}

output "invoke_arn" {
  description = "TODO(reto)"
  value       = aws_lambda_function.this.invoke_arn
}

// === ARCHIVO: infra/modules/dynamodb/outputs.tf ===
# Outputs del módulo DynamoDB
# Superficie de práctica: el estudiante debe implementar los outputs correctos

output "table_name" {
  description = "TODO(reto)"
  value       = aws_dynamodb_table.this.name
}

output "table_arn" {
  description = "TODO(reto)"
  value       = aws_dynamodb_table.this.arn
}

// === ARCHIVO: infra/modules/vpc/outputs.tf ===
# Outputs del módulo VPC
# Superficie de práctica: el estudiante debe implementar los outputs correctos

output "id" {
  description = "TODO(reto)"
  value       = aws_vpc.this.id
}

output "subnet_ids" {
  description = "TODO(reto)"
  value       = [aws_subnet.this[*].id]
}

output "security_group_ids" {
  description = "TODO(reto)"
  value       = [aws_security_group.this.id]
}

// === ARCHIVO: infra/environments/dev/backend.tf ===
terraform {
  backend "s3" {
    bucket         = "mobile-order-api-dev-terraform-state"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "mobile-order-api-dev-terraform-locks"
  }
}

// === ARCHIVO: infra/environments/dev/main.tf ===
# TODO(reto): Implementar la configuración de recursos para el entorno de desarrollo
# Este archivo debe instanciar los módulos de infraestructura necesarios:
# - Módulo de VPC para la red virtual
# - Módulo de Lambda para la función serverless
# - Módulo de DynamoDB para la base de datos
# - Módulo de API Gateway para exponer la API
#
# Consideraciones:
# - Usar las variables de entorno (var.environment, var.region)
# - Conectar los outputs de un módulo como inputs de otros
# - Aplicar políticas de IAM mínimas necesarias
# - Configurar el stage_name para API Gateway como "dev"

locals {
  environment = var.environment
  region      = var.region
}

// === ARCHIVO: infra/environments/prod/main.tf ===
# TODO(reto): Implementar la configuración de recursos para el entorno de producción
# Este archivo debe instanciar los módulos de infraestructura necesarios:
# - Módulo de VPC para la red virtual
# - Módulo de Lambda para la función serverless
# - Módulo de DynamoDB para la base de datos
# - Módulo de API Gateway para exponer la API
#
# Consideraciones:
# - Usar las variables de entorno (var.environment, var.region)
# - Conectar los outputs de un módulo como inputs de otros
# - Aplicar políticas de IAM mínimas necesarias
# - Configurar el stage_name para API Gateway como "prod"
# - Considerar mayor capacidad para producción (escalado)

locals {
  environment = var.environment
  region      = var.region
}

// === ARCHIVO: infra/environments/prod/backend.tf ===
terraform {
  backend "s3" {
    bucket         = "${var.project_name}-${var.environment}-terraform-state"
    key            = "prod/terraform.tfstate"
    region         = var.region
    encrypt        = true
    dynamodb_table = "${var.project_name}-${var.environment}-terraform-locks"
  }
}

// === ARCHIVO: infra/environments/outputs.tf ===
# Outputs globales del proyecto - expone los recursos aprovisionados para consumo externo
# Se referencian los módulos aprovisionados en cada entorno

# Referencia al módulo de API Gateway
module "api_gateway" {
  source = "../modules/api_gateway"

  project_name             = var.project_name
  api_gateway_stage_name  = var.api_gateway_stage_name
  lambda_invoke_arn       = module.lambda.invoke_arn
  lambda_function_name    = module.lambda.function_name
}

# Referencia al módulo de Lambda
module "lambda" {
  source = "../modules/lambda"

  project_name            = var.project_name
  environment             = var.environment
  lambda_runtime          = var.lambda_runtime
  lambda_handler          = var.lambda_handler
  dynamodb_table_arn      = module.dynamodb.table_arn
  vpc_security_group_ids  = module.vpc.security_group_ids
  vpc_subnet_ids          = module.vpc.subnet_ids
}

# Referencia al módulo de DynamoDB
module "dynamodb" {
  source = "../modules/dynamodb"

  project_name    = var.project_name
  environment     = var.environment
  read_capacity  = var.dynamodb_read_capacity
  write_capacity = var.dynamodb_write_capacity
}

# Referencia al módulo de VPC
module "vpc" {
  source = "../modules/vpc"

  project_name = var.project_name
  environment  = var.environment
  vpc_cidr     = var.vpc_cidr
}

# Output del API Gateway
output "api_gateway_id" {
  description = "ID del API Gateway REST API"
  value       = module.api_gateway.api_gateway_id
}

output "api_gateway_execution_arn" {
  description = "ARN de ejecución del API Gateway"
  value       = module.api_gateway.api_gateway_execution_arn
}

output "api_gateway_invoke_url" {
  description = "URL de invocación del API Gateway"
  value       = module.api_gateway.api_gateway_invoke_url
}

# Output de Lambda
output "lambda_function_name" {
  description = "Nombre de la función Lambda"
  value       = module.lambda.function_name
}

output "lambda_arn" {
  description = "ARN de la función Lambda"
  value       = module.lambda.arn
}

output "lambda_invoke_arn" {
  description = "ARN de invocación de la función Lambda"
  value       = module.lambda.invoke_arn
}

# Output de DynamoDB
output "dynamodb_table_name" {
  description = "Nombre de la tabla DynamoDB"
  value       = module.dynamodb.table_name
}

output "dynamodb_table_arn" {
  description = "ARN de la tabla DynamoDB"
  value       = module.dynamodb.table_arn
}

# Output de VPC
output "vpc_id" {
  description = "ID de la VPC"
  value       = module.vpc.id
}

output "vpc_subnet_ids" {
  description = "IDs de las subnets de la VPC"
  value       = module.vpc.subnet_ids
}

output "vpc_security_group_ids" {
  description = "IDs de los security groups de la VPC"
  value       = module.vpc.security_group_ids
}

# Output combinado - URL completa del endpoint de la API
output "api_endpoint_url" {
  description = "URL completa del endpoint de la API para la app móvil"
  value       = "${module.api_gateway.api_gateway_invoke_url}/orders"
}

// === ARCHIVO: infra/environments/dev/variables.tf ===
# Variables específicas del entorno de desarrollo
# Estas variables son consumidas por los módulos y recursos del entorno dev

variable "environment" {
  type        = string
  description = "Nombre del entorno de despliegue (desarrollo)"
  default     = "dev"
}

variable "region" {
  type        = string
  description = "Región de AWS donde se aprovisionarán los recursos"
  default     = "us-east-1"
}

// === ARCHIVO: infra/environments/prod/variables.tf ===
# Variables específicas del entorno de producción
# Estas variables son consumidas por los módulos y recursos del entorno prod

variable "environment" {
  type        = string
  description = "Nombre del entorno de despliegue (producción)"
  default     = "prod"
}

variable "region" {
  type        = string
  description = "Región de AWS donde se aprovisionarán los recursos"
  default     = "us-east-1"
}

variable "project_name" {
  type        = string
  description = "Nombre del proyecto para identificar recursos en AWS"
  default     = "mobile-order-api"
}

// === ARCHIVO: client/lib/main.dart ===
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'presentation/screens/order_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Order Management',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const OrderScreen(),
    );
  }
}

// === ARCHIVO: client/pubspec.yaml ===
name: reto
description: Reto de aprendizaje.
publish_to: none
version: 1.0.0+1

environment:
  sdk: ">=3.12.0 <4.0.0"

dependencies:
  flutter:
    sdk: flutter
  build_runner: 2.17.1
  flutter_riverpod: 2.6.1
  freezed: 3.2.5
  freezed_annotation: 2.4.4
  http: 1.6.0
  json_serializable: 6.15.2

dev_dependencies:
  flutter_test:
    sdk: flutter

flutter:
  uses-material-design: true

// === ARCHIVO: client/analysis_options.yaml ===
analyzer:
  exclude:
    - _pendiente/**

// === ARCHIVO: client/lib/data/sources/order_api_client.dart ===
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../domain/models/order.dart';

class OrderApiClient {
  final http.Client _client;
  final String baseUrl;

  OrderApiClient({required this.baseUrl, http.Client? client})
      : _client = client ?? http.Client();

  Future<Order> createOrder(Order order) async {
    try {
      final response = await _client.post(
        Uri.parse('$baseUrl/orders'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(order.toJson()),
      );

      if (response.statusCode != 201) {
        throw Exception('Failed to create order: ${response.statusCode}');
      }

      return Order.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw Exception('Failed to create order: $e');
    }
  }

  Future<Order> getOrder(String orderId) async {
    try {
      final response = await _client.get(
        Uri.parse('$baseUrl/orders/$orderId'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to get order: ${response.statusCode}');
      }

      return Order.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw Exception('Failed to get order: $e');
    }
  }
}

// === ARCHIVO: client/lib/domain/models/order.dart ===
import 'package:freezed_annotation/freezed_annotation.dart';

part 'order.freezed.dart';
part 'order.g.dart';

@freezed
class Order with _$Order {
  const Order._();

  const factory Order({
    required String id,
    required String userId,
    required List<OrderItem> items,
    required String status,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default(0.0) double total,
  }) = _Order;

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  double calculateTotal() {
    return items.fold(0.0, (sum, item) => sum + (item.price * item.quantity));
  }
}

@freezed
class OrderItem with _$OrderItem {
  const factory OrderItem({
    required String productId,
    required String name,
    required double price,
    required int quantity,
  }) = _OrderItem;

  factory OrderItem.fromJson(Map<String, dynamic> json) => _$OrderItemFromJson(json);
}

// === ARCHIVO: client/lib/domain/usecases/create_order.dart ===
import 'package:reto/domain/models/order.dart';
import 'package:reto/domain/repositories/order_repository.dart';

class CreateOrder {
  final OrderRepository repository;

  CreateOrder({required this.repository});

  Future<Order> call(Order order) async {
    try {
      if (order.items.isEmpty) {
        throw Exception('Order must have at least one item');
      }

      final createdOrder = await repository.createOrder(order);
      return createdOrder;
    } catch (e) {
      throw Exception('Failed to create order: $e');
    }
  }
}

// === ARCHIVO: client/lib/domain/usecases/get_order.dart ===
import 'package:reto/domain/models/order.dart';
import 'package:reto/domain/repositories/order_repository.dart';

class GetOrder {
  final OrderRepository repository;

  GetOrder({required this.repository});

  Future<Order> call(String orderId) async {
    try {
      if (orderId.isEmpty) {
        throw Exception('Order ID cannot be empty');
      }

      final order = await repository.getOrder(orderId);
      return order;
    } catch (e) {
      throw Exception('Failed to get order: $e');
    }
  }
}

// === ARCHIVO: client/lib/presentation/viewmodels/order_viewmodel.dart ===
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/order.dart';
import '../../domain/usecases/create_order.dart';
import '../../domain/usecases/get_order.dart';

class OrderViewModel extends StateNotifier<AsyncValue<Order?>> {
  final CreateOrder createOrder;
  final GetOrder getOrder;

  OrderViewModel({
    required this.createOrder,
    required this.getOrder,
  }) : super(const AsyncValue.data(null));

  Future<void> submitOrder(Order order) async {
    state = const AsyncValue.loading();
    try {
      final createdOrder = await createOrder(order);
      state = AsyncValue.data(createdOrder);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> fetchOrder(String orderId) async {
    state = const AsyncValue.loading();
    try {
      final order = await getOrder(orderId);
      state = AsyncValue.data(order);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}

// === ARCHIVO: client/lib/android/app/src/main/AndroidManifest.xml ===
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <uses-permission android:name="android.permission.INTERNET"/>
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>
    
    <application
        android:label="reto"
        android:name="${applicationName}"
        android:icon="@mipmap/ic_launcher"
        android:usesCleartextTraffic="true">
        <activity
            android:name=".MainActivity"
            android:exported="true"
            android:launchMode="singleTop"
            android:taskAffinity=""
            android:theme="@style/LaunchTheme"
            android:configChanges="orientation|keyboardHidden|keyboard|screenSize|smallestScreenSize|locale|layoutDirection|fontScale|screenLayout|density|uiMode"
            android:hardwareAccelerated="true"
            android:windowSoftInputMode="adjustResize">
            <meta-data
              android:name="io.flutter.embedding.android.NormalTheme"
              android:resource="@style/NormalTheme"
              />
            <intent-filter>
                <action android:name="android.intent.action.MAIN"/>
                <category android:name="android.intent.category.LAUNCHER"/>
            </intent-filter>
        </activity>
        <meta-data
            android:name="flutterEmbedding"
            android:value="2" />
    </application>
    <queries>
        <intent>
            <action android:name="android.intent.action.PROCESS_TEXT"/>
            <data android:mimeType="text/plain"/>
        </intent>
    </queries>
</manifest>

// === ARCHIVO: client/lib/data/repositories/order_repository_impl.dart ===
import 'package:http/http.dart' as http;
import '../../domain/models/order.dart';
import '../sources/order_api_client.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderApiClient _apiClient;
  final http.Client _httpClient;

  OrderRepositoryImpl({
    required OrderApiClient apiClient,
    required http.Client httpClient,
  })  : _apiClient = apiClient,
        _httpClient = httpClient;

  @override
  Future<Order> createOrder(Order order) async {
    try {
      final orderWithTotal = order.copyWith(
        total: order.calculateTotal(),
      );
      final createdOrder = await _apiClient.createOrder(orderWithTotal);
      return createdOrder;
    } catch (e) {
      throw OrderRepositoryException(
        message: 'Failed to create order',
        originalError: e is Exception ? e : Exception(e.toString()),
      );
    }
  }

  @override
  Future<Order> getOrder(String orderId) async {
    try {
      if (orderId.isEmpty) {
        throw OrderRepositoryException(
          message: 'Order ID cannot be empty',
          originalError: null,
        );
      }
      final order = await _apiClient.getOrder(orderId);
      return order;
    } catch (e) {
      if (e is OrderRepositoryException) {
        rethrow;
      }
      throw OrderRepositoryException(
        message: 'Failed to get order: $orderId',
        originalError: e is Exception ? e : Exception(e.toString()),
      );
    }
  }

  @override
  Future<List<Order>> getOrders() async {
    try {
      const knownOrderIds = [
        'order-001',
        'order-002',
        'order-003',
      ];
      
      final List<Order> orders = [];
      
      for (final orderId in knownOrderIds) {
        try {
          final order = await _apiClient.getOrder(orderId);
          orders.add(order);
        } catch (e) {
          continue;
        }
      }
      
      return orders;
    } catch (e) {
      throw OrderRepositoryException(
        message: 'Failed to fetch orders list',
        originalError: e is Exception ? e : Exception(e.toString()),
      );
    }
  }

  @override
  Future<Order> updateOrderStatus(String orderId, String status) async {
    try {
      if (orderId.isEmpty) {
        throw OrderRepositoryException(
          message: 'Order ID cannot be empty',
          originalError: null,
        );
      }

      if (status.isEmpty) {
        throw OrderRepositoryException(
          message: 'Status cannot be empty',
          originalError: null,
        );
      }

      final validStatuses = ['pending', 'processing', 'completed', 'cancelled'];
      if (!validStatuses.contains(status.toLowerCase())) {
        throw OrderRepositoryException(
          message: 'Invalid status value: $status',
          originalError: null,
        );
      }

      final currentOrder = await _apiClient.getOrder(orderId);
      
      final updatedOrder = currentOrder.copyWith(
        status: status.toLowerCase(),
        updatedAt: DateTime.now(),
      );
      
      return updatedOrder;
    } catch (e) {
      if (e is OrderRepositoryException) {
        rethrow;
      }
      throw OrderRepositoryException(
        message: 'Failed to update order status for: $orderId',
        originalError: e is Exception ? e : Exception(e.toString()),
      );
    }
  }

  @override
  void dispose() {
    _httpClient.close();
  }
}

class OrderRepositoryException implements Exception {
  final String message;
  final Exception? originalError;

  OrderRepositoryException({
    required this.message,
    this.originalError,
  });

  @override
  String toString() => 'OrderRepositoryException: $message';
}

// === ARCHIVO: client/lib/presentation/screens/order_screen.dart ===
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/order.dart';
import '../viewmodels/order_viewmodel.dart';

class OrderScreen extends ConsumerStatefulWidget {
  const OrderScreen({super.key});

  @override
  ConsumerState<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends ConsumerState<OrderScreen> {
  final _formKey = GlobalKey<FormState>();
  final _orderIdController = TextEditingController();
  final List<OrderItem> _currentItems = [];
  final _productNameController = TextEditingController();
  final _priceController = TextEditingController();
  final _quantityController = TextEditingController();

  @override
  void dispose() {
    _orderIdController.dispose();
    _productNameController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  void _addItem() {
    if (_productNameController.text.isNotEmpty &&
        _priceController.text.isNotEmpty &&
        _quantityController.text.isNotEmpty) {
      final price = double.tryParse(_priceController.text) ?? 0.0;
      final quantity = int.tryParse(_quantityController.text) ?? 1;

      setState(() {
        _currentItems.add(OrderItem(
          productId: 'prod_${DateTime.now().millisecondsSinceEpoch}',
          name: _productNameController.text,
          price: price,
          quantity: quantity,
        ));
      });

      _productNameController.clear();
      _priceController.clear();
      _quantityController.clear();
    }
  }

  void _removeItem(int index) {
    setState(() {
      _currentItems.removeAt(index);
    });
  }

  Future<void> _submitOrder() async {
    if (_currentItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Agrega al menos un producto al pedido')),
      );
      return;
    }

    final order = Order(
      id: 'order_${DateTime.now().millisecondsSinceEpoch}',
      userId: 'user_123',
      items: _currentItems,
      status: 'pending',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    await ref.read(orderViewModelProvider.notifier).submitOrder(order);
  }

  Future<void> _fetchOrder() async {
    final orderId = _orderIdController.text.trim();
    if (orderId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ingresa un ID de pedido')),
      );
      return;
    }

    await ref.read(orderViewModelProvider.notifier).fetchOrder(orderId);
  }

  @override
  Widget build(BuildContext context) {
    final orderState = ref.watch(orderViewModelProvider);

    ref.listen<OrderViewModelState>(orderViewModelProvider, (previous, next) {
      if (next.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${next.error}'),
            backgroundColor: Colors.red,
          ),
        );
      } else if (next.order != null && previous?.order == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Pedido procesado exitosamente'),
            backgroundColor: Colors.green,
          ),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestión de Pedidos'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildSectionTitle('Crear Nuevo Pedido'),
              const SizedBox(height: 16),
              _buildProductInputFields(),
              const SizedBox(height: 16),
              _buildItemsList(),
              const SizedBox(height: 16),
              _buildSubmitButton(orderState),
              const Divider(height: 32),
              _buildSectionTitle('Consultar Pedido'),
              const SizedBox(height: 16),
              _buildOrderSearchField(orderState),
              const SizedBox(height: 16),
              _buildOrderDetails(orderState),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
    );
  }

  Widget _buildProductInputFields() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _productNameController,
              decoration: const InputDecoration(
                labelText: 'Nombre del producto',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _priceController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Precio',
                      border: OutlineInputBorder(),
                      prefixText: '\$ ',
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _quantityController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Cantidad',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: _addItem,
              icon: const Icon(Icons.add),
              label: const Text('Agregar Producto'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemsList() {
    if (_currentItems.isEmpty) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'No hay productos en el pedido',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),
        ),
      );
    }

    return Card(
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _currentItems.length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          final item = _currentItems[index];
          return ListTile(
            title: Text(item.name),
            subtitle: Text('Cantidad: ${item.quantity}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '\$${(item.price * item.quantity).toStringAsFixed(2)}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _removeItem(index),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSubmitButton(OrderViewModelState state) {
    final isLoading = state.isLoading;

    return ElevatedButton(
      onPressed: isLoading ? null : _submitOrder,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      child: isLoading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : const Text(
              'Confirmar Pedido',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
    );
  }

  Widget _buildOrderSearchField(OrderViewModelState state) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _orderIdController,
            decoration: const InputDecoration(
              labelText: 'ID del pedido',
              border: OutlineInputBorder(),
              hintText: 'Ingresa el ID del pedido',
            ),
          ),
        ),
        const SizedBox(width: 12),
        ElevatedButton(
          onPressed: state.isLoading ? null : _fetchOrder,
          child: state.isLoading
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Buscar'),
        ),
      ],
    );
  }

  Widget _buildOrderDetails(OrderViewModelState state) {
    if (state.order == null) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'No hay información del pedido',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),
        ),
      );
    }

    final order = state.order!;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow('ID', order.id),
            _buildDetailRow('Usuario', order.userId),
            _buildDetailRow('Estado', order.status),
            _buildDetailRow(
              'Fecha de creación',
              _formatDate(order.createdAt),
            ),
            _buildDetailRow(
              'Última actualización',
              _formatDate(order.updatedAt),
            ),
            const Divider(),
            const Text(
              'Productos:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...order.items.map((item) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${item.name} x${item.quantity}'),
                      Text('\$${(item.price * item.quantity).toStringAsFixed(2)}'),
                    ],
                  ),
                )),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  '\$${order.calculateTotal().toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}

// === ARCHIVO: client/lib/domain/repositories/order_repository.dart ===
import '../models/order.dart';

abstract class OrderRepository {
  Future<Order> createOrder(Order order);
  Future<Order> getOrder(String orderId);
  Future<List<Order>> getOrders();
  Future<Order> updateOrderStatus(String orderId, String status);
}
```
