# Outputs del módulo VPC
# Superficie de práctica: el estudiante debe implementar los outputs correctos

output "id" {
  description = "TODO(reto)"
  value       = aws_vpc.this.id
}

output "subnet_ids" {
  description = "TODO(reto)"
  value       = [aws_subnet.this[*].id]
}

output "security_group_ids" {
  description = "TODO(reto)"
  value       = [aws_security_group.this.id]
}