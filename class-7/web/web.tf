resource "aws_instance" "web" {
    ami                     = "ami-0a5c3558529277641"
    instance_type           = "t2.micro"
    security_groups         = [module.sg.sg_name]
    user_data = file("./web/startup-script.sh")
    tags = {
        "Name" = "webserver"
    }  
}

output "pub_ip" {
    value = module.eip.PublicIP
}

module "eip" {
    source = "../eip"
    instance_id = aws_instance.web.id
}

module "sg" {
    source = "../sg"
}
