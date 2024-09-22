variable "ingressrule" {
    type = list(number)
    default = [80,443]
}

variable "egressrule" {
    type = list(number)
    default = [80,443]
}

output "sg_name" {
    value = aws_security_group.webtraffic.name
}

resource "aws_security_group" "webtraffic" {
    name = "Allow HTTPS"

    dynamic "ingress" {
        iterator        = port
        for_each = var.ingressrule
        content {
            from_port = port.value
            to_port = port.value
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
            protocol        = "TCP"
            cidr_blocks     =  ["0.0.0.0/0"]
    }
}

}