resource "aws_instance" "db" {
    ami                     = "ami-0a5c3558529277641"
    instance_type           = "t2.micro"
    tags = {
        "Name" = "db server"
    }
  
}

output "PrivateIP" {
    value = aws_instance.db.private_ip  
}