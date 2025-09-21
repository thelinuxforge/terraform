provider "aws" {
    region = "us-east-1"
}

module "db" {
    source = "./db"
    server_names = ["db1", "db2", "db3"]
  
}

output "private_ips" {
    value = module.db.PrivateIP
}