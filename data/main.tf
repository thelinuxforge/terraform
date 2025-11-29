provider "aws" {
  region = "us-east-1"
}

# Data block to fetch latest Ubuntu AMI
data "aws_ami" "ubuntu_latest" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}



# Use the AMI in an EC2 instance
resource "aws_instance" "example" {
  ami           = data.aws_ami.ubuntu_latest.id
  instance_type = "t3.micro"
}
