# TODO(reto): Implementar la configuración de recursos para el entorno de producción
# Este archivo debe instanciar los módulos de infraestructura necesarios:
# - Módulo de VPC para la red virtual
# - Módulo de Lambda para la función serverless
# - Módulo de DynamoDB para la base de datos
# - Módulo de API Gateway para exponer la API
#
# Consideraciones:
# - Usar las variables de entorno (var.environment, var.region)
# - Conectar los outputs de un módulo como inputs de otros
# - Aplicar políticas de IAM mínimas necesarias
# - Configurar el stage_name para API Gateway como "prod"
# - Considerar mayor capacidad para producción (escalado)

locals {
  environment = var.environment
  region      = var.region
}