provider "aws" {
    region = "us-east-1"
}

module "db" {
    source = "./db"
}

module "web" {
    source = "./web"
}

output "PublicIP" {
    value = module.web.pub_ip
}

output "PrivateIP" {
    value = module.db.PrivateIP  
}

