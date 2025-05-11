variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "vm_admin_user" {
  description = "admin username for windows VM"
  type = string
}

variable "vm_password" {
  description = "vm password"
  type = string
  sensitive = true
}



variable "vm_size" {
  description = "VM Size"
  type = string
  default = "Standard_B2s"
}