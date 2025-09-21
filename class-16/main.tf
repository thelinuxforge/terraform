provider "aws" {
    region = "us-east-1"
}

resource "aws_instance" "ec2" {
    ami                     = "ami-0a5c3558529277641"
    instance_type           = "t2.micro"

    tags = {
        Name = "main"
    }
}

# count
# resource "aws_iam_user" "example" {
#    count = length(var.user_names)
#    name  = var.user_names[count.index]
# }

# variable "user_names" {
#    description = "IAM usernames"
#    type        = list(string)
#    default     = ["user1", "user2", "user3"]
# }

#for_each
#resource "aws_iam_user" "example" {
#    for_each = var.user_names
#    name  = each.value
#}

#variable "user_names" {
#    description = "IAM usernames"
#    type        = set(string)
#    default     = ["user1", "user2", "user3"]
#}

#for loop
#resource "aws_iam_user" "example" {
#    for_each = var.user_names
#    name  = each.value
#}

#output "print_the_names" {
#    value = [for user in aws_iam_user.example : user.name]
#}

#variable "user_names" {
#    description = "IAM usernames"
#    type        = set(string)
#    default     = ["user1", "user2", "user3"]
#}
