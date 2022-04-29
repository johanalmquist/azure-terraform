locals {
  bastion_name = "${random_pet.project_name.id}-bastion"
}
resource "azurerm_public_ip" "bastionpublicip" {
  name                = "${local.bastion_name}-ip"
  location            = azurerm_resource_group.terrform.location
  resource_group_name = azurerm_resource_group.terrform.name
  allocation_method   = "Static"
  sku                 = "Standard"
  depends_on = [
    azurerm_resource_group.terrform
  ]
  tags = local.common_tags
}


resource "azurerm_bastion_host" "bastion" {
  name                = "${random_pet.project_name.id}-bastion"
  location            = azurerm_resource_group.terrform.location
  resource_group_name = azurerm_resource_group.terrform.name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.bastion.id
    public_ip_address_id = azurerm_public_ip.bastionpublicip.id
  }

  depends_on = [
    azurerm_resource_group.terrform
  ]
  tags = local.common_tags
}
