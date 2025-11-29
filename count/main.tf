variable "instance_names" {
  default = ["alpha", "beta", "gamma"]
}

resource "aws_instance" "web" {
  count         = 4
  ami           = "ami-0a5c3558529277641"
  instance_type = "t2.micro"

  tags = {
    Name = var.instance_names[count.index]
  }
}