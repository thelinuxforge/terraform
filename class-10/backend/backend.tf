terraform {
  backend "s3" {
    bucket = "thelinuxforge-terraform-1"
    key = "terraform/main-vpc.tfstate"
    region = "us-east-1"
    #access_key = ""
    #secret_key = ""
  }
}