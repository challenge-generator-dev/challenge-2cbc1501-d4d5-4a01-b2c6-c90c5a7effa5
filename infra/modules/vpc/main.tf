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