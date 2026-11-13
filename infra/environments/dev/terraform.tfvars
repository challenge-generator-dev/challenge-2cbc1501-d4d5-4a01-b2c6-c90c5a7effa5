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