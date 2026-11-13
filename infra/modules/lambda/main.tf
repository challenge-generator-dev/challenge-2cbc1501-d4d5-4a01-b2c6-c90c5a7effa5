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