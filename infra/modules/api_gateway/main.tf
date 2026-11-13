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