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