provider "aws" {
    region = "us-east-1"
}

# variable "number_of_servers" {
#     type = number
# }



resource "aws_instance" "ec2" {
    ami                     = "ami-0a5c3558529277641"
    instance_type           = "t2.micro"
    #count = var.number_of_servers
    count = var.environment == "prod" ? 2 : 0
}