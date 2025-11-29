provider "aws" {
  region = "us-east-1"
}

locals {
  environment   = "dev"
  app_name      = "myapp"
  instance_name = "${local.app_name}-${local.environment}-ec2"
}

# You need a valid AMI in us-east-1
# Here I’ll use Amazon Linux 2 AMI (free tier eligible)
resource "aws_instance" "example" {
  ami           = "ami-0c02fb55956c7d316" # Amazon Linux 2 AMI in us-east-1
  instance_type = "t3.micro"

  tags = {
    Name = local.instance_name
  }
}
