terraform {
  backend "s3" {
    bucket         = "mobile-order-api-dev-terraform-state"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "mobile-order-api-dev-terraform-locks"
  }
}