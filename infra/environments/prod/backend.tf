terraform {
  backend "s3" {
    bucket         = "${var.project_name}-${var.environment}-terraform-state"
    key            = "prod/terraform.tfstate"
    region         = var.region
    encrypt        = true
    dynamodb_table = "${var.project_name}-${var.environment}-terraform-locks"
  }
}