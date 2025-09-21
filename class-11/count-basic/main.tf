provider "aws" {
    region = "us-east-1"
}

resource "aws_instance" "db" {
    ami                     = "ami-0a5c3558529277641"
    instance_type           = "t2.micro"
    count = 3
}