In Terraform, variables are used to pass dynamic values to your configuration, making it more flexible and reusable. Here’s a brief explanation of key concepts related to Terraform variables:

Declaring a Variable: Variables are declared using the variable block. You can specify the type, default value, and description.

variable "example_var" {
  type        = string
  default     = "default_value"
  description = "An example variable"
}
Types of Variables:

string: A single string value.
number: A numeric value (integer or float).
bool: A boolean value (true or false).
list: A collection of values ordered by index.
map: A collection of key-value pairs.
Example:


variable "allowed_ips" {
  type = list(string)
}

variable "instance_tags" {
  type = map(string)
}
Default Values: You can provide a default value, which will be used if the variable isn't defined elsewhere.


variable "region" {
  type    = string
  default = "us-west-1"
}
Input Values: Variables can be provided via:

Command-line arguments (terraform apply -var="region=us-west-2").
Environment variables (TF_VAR_region="us-west-2").
terraform.tfvars or *.auto.tfvars files.
Usage: You use a variable by referencing it as var.<variable_name>.


provider "aws" {
  region = var.region
}
Variable Validation: You can add validation rules for variables to ensure that the input meets specific criteria.


variable "instance_count" {
  type = number
  validation {
    condition     = var.instance_count > 0
    error_message = "Instance count must be greater than 0"
  }
}
Sensitive Variables: Variables can be marked as sensitive to prevent their values from being displayed in the output.


variable "password" {
  type      = string
  sensitive = true
}
In summary, variables in Terraform help in making the infrastructure as code (IaC) configuration flexible and reusable by allowing dynamic input.