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