locals {
  resource_location = "West Europe"
  subnet_address_prefix = ["10.0.0.0/24","10.0.1.0/24"]

  subnet_values = {
    subnet_name = ["websubnet","dbsubnet"]
    subnet_address_prefix = ["10.0.0.0/24","10.0.1.0/24"]
  }
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "staging"
}