resource "azurerm_public_ip" "bastionpublicip" {
  name                = "Bastion-public-ip"
  location            = azurerm_resource_group.terrform.location
  resource_group_name = azurerm_resource_group.terrform.name
  allocation_method   = "Static"
  sku                 = "Standard"
  depends_on = [
    azurerm_resource_group.terrform
  ]
}


resource "azurerm_bastion_host" "bastion" {
  name                = "bastion"
  location            = azurerm_resource_group.terrform.location
  resource_group_name = azurerm_resource_group.terrform.name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = module.vnet.vnet_subnets[0]
    public_ip_address_id = azurerm_public_ip.bastionpublicip.id
  }

  depends_on = [
    azurerm_resource_group.terrform
  ]
}
