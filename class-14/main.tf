provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "myec2db" {
  ami           = "ami-0a5c3558529277641"
  instance_type = "t2.micro"
  tags = {
    Name = "DB server"
  }
}

resource "aws_instance" "myec2" {
  ami           = "ami-0a5c3558529277641"
  instance_type = "t2.micro"
  tags = {
    Name = "Web server"
  }
  depends_on = [aws_instance.myec2db]
}

data "aws_instances" "dbsearch" {
  filter {
    name   = "tag:Name"
    values = ["DB server"]
  }
}

output "dbservers" {
  value = data.aws_instances.dbsearch.id
}

