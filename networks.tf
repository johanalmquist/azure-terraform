variable "address_spaces" {
  type        = list(string)
  description = "List of Address spaces to use in Vnet"
  default     = ["10.0.0.0/16"]
}

variable "subnet_prefixes" {
  type        = list(string)
  description = "List of subnets"
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "subnet_names" {
  type        = list(string)
  description = "List of subnet names"
  default     = ["terraform-1", "terraform-2"]
}

module "vnet" {
  source              = "Azure/vnet/azurerm"
  vnet_name           = var.resource_group_name
  resource_group_name = azurerm_resource_group.terrform.name
  address_space       = var.address_spaces[*]
  subnet_prefixes     = var.subnet_prefixes[*]
  subnet_names        = var.subnet_names[*]
  depends_on = [
    azurerm_resource_group.terrform
  ]

  tags = local.common_tags
}


