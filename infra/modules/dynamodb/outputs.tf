# Outputs del módulo DynamoDB
# Superficie de práctica: el estudiante debe implementar los outputs correctos

output "table_name" {
  description = "TODO(reto)"
  value       = aws_dynamodb_table.this.name
}

output "table_arn" {
  description = "TODO(reto)"
  value       = aws_dynamodb_table.this.arn
}