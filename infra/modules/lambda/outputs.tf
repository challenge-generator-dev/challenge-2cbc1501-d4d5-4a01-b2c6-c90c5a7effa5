# Outputs del módulo Lambda
# Superficie de práctica: el estudiante debe implementar los outputs correctos

output "function_name" {
  description = "TODO(reto)"
  value       = aws_lambda_function.this.function_name
}

output "arn" {
  description = "TODO(reto)"
  value       = aws_lambda_function.this.arn
}

output "invoke_arn" {
  description = "TODO(reto)"
  value       = aws_lambda_function.this.invoke_arn
}