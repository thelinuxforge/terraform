provider "aws" {
  region = "us-east-1"
}

# 🔍 Fetch the latest Amazon Linux 2 AMI
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# 📦 Define locals using the data block
locals {
  ami_id        = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"
  tags = {
    Name        = "DataDrivenInstance"
    Environment = "Dev"
  }
}

# 🚀 Launch EC2 instance using locals
resource "aws_instance" "example" {
  ami           = local.ami_id
  instance_type = local.instance_type

  tags = local.tags
}