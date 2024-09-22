provider "aws" {
    region = "us-east-1"
}

resource "aws_instance" "ec2" {
    ami                     = "ami-0e54eba7c51c234f6"
    instance_type           = "t2.micro"
        tags = {
            Name = "tf-example"
        }
    
}

resource "aws_eip" "elasticip" {
  instance = aws_instance.ec2.id
  domain   = "vpc"
}

output "eip" {
    value = aws_eip.elasticip.public_ip
}
