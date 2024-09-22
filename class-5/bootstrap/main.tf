provider "aws" {
    region = "us-east-1"
}

variable "ingressrule" {
    type = list(number)
    default = [80,443]
  
}

variable "egressrule" {
    type = list(number)
    default = [80,443]
  
}

# resource "aws_instance" "db" {
#     ami                     = "ami-0a5c3558529277641"
#     instance_type           = "t2.micro"
#     tags = {
#         "Name" = "db server"
#     }
  
# }

resource "aws_instance" "ec2" {
    ami                     = "ami-0a5c3558529277641"
    instance_type           = "t2.micro"
    security_groups         = [aws_security_group.webtraffic.name]
    user_data = file("startup-script.sh")
    tags = {
        "Name" = "webserver"
    }
    
}

resource "aws_security_group" "webtraffic" {
    name                = "Allow HTTPS"

    dynamic "ingress" {
        iterator        = port
        for_each = var.ingressrule
        content {
            from_port = port.value
            to_port = port.value
            # from_port       = 443
            # to_port         = 443
            protocol        = "TCP"
            cidr_blocks     =  ["0.0.0.0/0"]
    }
  }

    dynamic "egress" {        
        iterator        = port
        for_each = var.egressrule
        content {
            from_port = port.value
            to_port = port.value
            # from_port       = 443
            # to_port         = 443
            protocol        = "TCP"
            cidr_blocks     =  ["0.0.0.0/0"]
    }

}

}

resource "aws_eip" "elasticip" {
  instance = aws_instance.ec2.id
  domain   = "vpc"
}

output "PublicIP" {
    value = aws_eip.elasticip.public_ip
}

output "PrivateIP" {
    value = aws_instance.ec2.private_ip  
}

