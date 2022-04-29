resource "azurerm_resource_group" "terrform" {
  name     = var.resource_group_name
  location = var.location
  tags     = local.common_tags
}

resource "random_pet" "project_name" {
}
