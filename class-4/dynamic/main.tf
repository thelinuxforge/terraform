provider "aws" {
    region = "us-east-1"
}

variable "ingressrule" {
    type = list(number)
    default = [80,443]
  
}

variable "egressrule" {
    type = list(number)
    default = [80,443,25,22]
  
}

resource "aws_instance" "ec2" {
    ami                     = "ami-0a5c3558529277641"
    instance_type           = "t2.micro"
    security_groups         = [aws_security_group.webtraffic.name]  
    
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
            cidr_blocks     =  ["0.0.0.0/32"]
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
            cidr_blocks     =  ["0.0.0.0/32"]
    }

}

}