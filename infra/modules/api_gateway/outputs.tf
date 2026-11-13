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