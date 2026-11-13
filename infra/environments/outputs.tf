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