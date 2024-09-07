resource "aws_instance" "this" {
  ami                     = "ami-0a5c3558529277641"
  instance_type           = "t2.micro"
}