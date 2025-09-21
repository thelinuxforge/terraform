provider "aws" {
    region = "us-east-1"
}

resource "aws_db_instance" "myRDS" {
    allocated_storage    = 20
    db_name              = "mydb"
    engine               = "mariadb"
    engine_version       = "10.11.8"
    instance_class       = "db.t3.micro"
    username             = "linuxforge"
    password             = "linuxforge123"
    parameter_group_name = "default.mariadb10.11"
    skip_final_snapshot  = true
    identifier = "my-db"
}