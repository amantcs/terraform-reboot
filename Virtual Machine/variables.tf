variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "vm_admin_user" {
  description = "admin username for windows VM"
  type = string
}



variable "vm_size" {
  description = "VM Size"
  type = string
  default = "Standard_B2s"
}

variable "vm_name" {
  description = "VM Name"
  type = string
  default = "example-machine"

}