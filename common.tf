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
}

variable "vm_password" {
  type        = string
  description = "Password to login into linuxvm"
  sensitive   = true
}

variable "cert_path" {
  type    = string
  default = ""
}

variable "environment" {
  type    = string
  default = ""
}

locals {
  common_tags = {
    certPath    = var.cert_path
    environment = var.environment
    project     = random_pet.project_name.id
  }
}
