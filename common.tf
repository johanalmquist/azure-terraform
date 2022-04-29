variable "location" {
  type        = string
  description = "Location region in Azure"
  default     = "Sweden Central"
}

variable "resource_group_name" {
  type        = string
  description = "Name of default resource group"
  default     = "Terraform"

}

variable "vm_username" {
  type        = string
  description = "Username to login in to linuxvm"
  sensitive   = true
}

variable "vm_password" {
  type        = string
  description = "Password to login into linuxvm"
  sensitive   = true
}

locals {
  common_tags = {
    certPath    = "AZ-700"
    environment = "testing"
  }
}
