variable "names" {
  default = ["alpha", "beta", "gamma"]
}

locals {
  upper_names = [for name in var.names : upper(name)]
}

output "upper_names_output" {
  value       = local.upper_names
  description = "The list of country names, all capitalized."
}