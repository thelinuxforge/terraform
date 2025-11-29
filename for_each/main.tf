# variable "security_groups" {
#   default = {
#     web     = 80
#     ssh     = 22
#     db      = 3306
#   }
# }

# resource "aws_security_group" "custom" {
#   for_each = var.security_groups

#   name        = "${each.key}-sg"
#   description = "Security group for ${each.key} access"
#   vpc_id      = "vpc-019ce9f2520b3f31a"  # Replace with your actual VPC ID

#   ingress {
#     from_port   = each.value
#     to_port     = each.value
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "${each.key}-sg"
#   }
# }

variable "bucket_names" {
  type    = list(string)
  default = ["my-unique-linux-4"]
}

resource "aws_s3_bucket" "example" {
  for_each = toset(var.bucket_names)
  bucket   = each.key
  tags = {
    Name = each.key
  }
}

resource "aws_s3_bucket_acl" "example_acl" {
  for_each = aws_s3_bucket.example
  bucket   = each.value.id
  acl      = "private"
}

data "aws_s3_bucket" "example_bucket" {
  for_each = toset(var.bucket_names)
  bucket   = each.key
}

output "s3_bucket_arns" {
  value       = { for k, v in data.aws_s3_bucket.example_bucket : k => v.arn }
  description = "The ARNs of the specified S3 buckets."
}

