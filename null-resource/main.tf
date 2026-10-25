
provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "web" {
  ami           = "ami-0a5c3558529277641"
  instance_type = "t2.micro"

  tags = {
    Name = "demo-server"
  }
}

resource "null_resource" "configure" {
  triggers = {
    instance_id = aws_instance.web.id
  }

  provisioner "local-exec" {
    command = "echo EC2 instance ${aws_instance.web.id} has been created"
  }
}
