provider "aws" {
    region = "us-east-1"
}

resource "aws_vpc" "example" {
  cidr_block = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "main"
  }
}

# resource "local_file" "pet" {
#   filename = "/root/backup/Devops/terrafrom/class-1/pets.txt"
#   content = "We love pets! today we are studying"
# }


