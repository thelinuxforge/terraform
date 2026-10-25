
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "akshay-terraform-demo-2026-unique"

  tags = {
    Name        = "My Terraform Bucket"
    Environment = "Dev"
  }
}

# terraform plan
# For a drift-only check, without proposing configuration changes:
# terraform plan -refresh-only
# To save the refresh-only plan for review:
# terraform plan -refresh-only -out=refresh.tfplan
# terraform show refresh.tfplanterraform plan
# Option A: Restore the resource to match main.tf
# terraform plan
# terraform apply
# Option B: Update the state file to reflect actual AWS changes
# terraform plan -refresh-only
# terraform apply -refresh-only