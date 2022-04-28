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


locals {
  common_tags = {
    certPath    = "AZ-700"
    environment = "testing"
  }
}
