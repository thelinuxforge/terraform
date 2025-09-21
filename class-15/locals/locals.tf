provider "aws" {
    region = "us-east-1"
}

locals {
  staging_env = "Staging"
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = {
    #Name = "Staging-vpc-tag"
    Name = "${local.staging_env}-vpc-tag"
  }
}

resource "aws_subnet" "subnet-tagging" {

  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  tags = {
    # Name = "Staging-subnet-tag"
    Name = "${local.staging_env}-vpc-tag"
  }
}

