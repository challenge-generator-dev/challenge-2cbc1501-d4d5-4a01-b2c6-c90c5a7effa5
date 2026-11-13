# Terraform Infrastructure for API Gateway, Lambda, and DynamoDB

## Project Structure

```
.
├── environments/
│   ├── dev/
│   │   ├── backend.tf
│   │   ├── main.tf
│   │   └── terraform.tfvars
│   ├── prod/
│   │   ├── backend.tf
│   │   └── main.tf
│   ├── outputs.tf
│   └── variables.tf
├── modules/
│   ├── api_gateway/
│   │   ├── main.tf
│   │   └── outputs.tf
│   ├── dynamodb/
│   │   ├── main.tf
│   │   └── outputs.tf
│   ├── lambda/
│   │   ├── main.tf
│   │   └── outputs.tf
│   └── vpc/
│       ├── main.tf
│       └── outputs.tf
├── providers.tf
├── versions.tf
└── README.md
```

## Prerequisites

1. **Terraform** >= 1.9.0 installed
2. **AWS CLI** configured with proper credentials (`aws configure`)
3. **AWS Account** with permissions to create:
   - API Gateway
   - Lambda functions
   - DynamoDB tables
   - VPC resources

## Setup Instructions

### Initialize Terraform

```bash
cd environments/dev
terraform init
```

### Review and Plan

```bash
terraform plan
```

### Apply Changes

```bash
terraform apply
```

## Environment Configuration

- **Development**: `environments/dev/`
- **Production**: `environments/prod/`

Each environment has its own:
- `backend.tf` (remote state configuration)
- `main.tf` (module instantiation)
- `terraform.tfvars` (environment-specific variables, dev only)

## Modules Overview

| Module       | Purpose                                                                 |
|--------------|-------------------------------------------------------------------------|
| `api_gateway`| Creates REST API Gateway with routes and integrations                  |
| `lambda`     | Deploys Lambda functions with proper IAM roles and permissions         |
| `dynamodb`   | Creates DynamoDB tables with appropriate capacity settings             |
| `vpc`        | Sets up VPC, subnets, security groups, and networking requirements     |

## Outputs

After applying, Terraform will output:
- API Gateway endpoint URL
- Lambda function ARNs
- DynamoDB table names
- VPC configuration details

## Validation

To verify the infrastructure:
```bash
terraform output
```

For a specific environment:
```bash
cd environments/dev
terraform output
```