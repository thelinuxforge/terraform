# resource "aws_instance" "ec2" {
#     ami                     = "ami-0e54eba7c51c234f6"
#     instance_type           = "t2.micro"
# }

module "ec2module" {

    source = "./ec2"
    ec2name = "Name for module"
}

output "module_output" {
    value = module.ec2module.instance_id
}