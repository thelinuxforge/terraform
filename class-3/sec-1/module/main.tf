provider "aws" {
    region = "us-east-1"
}

module "ec2" {
    source = "./ec2"
    #count = 3 -> deprecated
    for_each = toset(["dev", "qa", "stage"])
}