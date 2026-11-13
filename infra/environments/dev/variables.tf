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