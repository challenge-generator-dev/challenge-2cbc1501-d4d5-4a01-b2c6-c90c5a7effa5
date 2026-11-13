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