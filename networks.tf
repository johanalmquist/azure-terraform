##########################
# TERRAFORM
##########################
resource "azurerm_virtual_network" "terraform" {
  name                = "${random_pet.project_name.id}-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.terrform.location
  resource_group_name = azurerm_resource_group.terrform.name

  tags = local.common_tags
}

resource "azurerm_subnet" "bastion" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = azurerm_resource_group.terrform.name
  virtual_network_name = azurerm_virtual_network.terraform.name
  address_prefixes     = ["10.0.0.0/29"]
}



resource "azurerm_subnet" "linux_hosts" {
  name                 = "${random_pet.project_name.id}-linux-hosts"
  resource_group_name  = azurerm_resource_group.terrform.name
  virtual_network_name = azurerm_virtual_network.terraform.name
  address_prefixes     = ["10.0.1.0/24"]
}


##########################
# JANNE
##########################

resource "azurerm_virtual_network" "janne" {
  name                = "janne-vnet"
  address_space       = ["10.1.0.0/16"]
  location            = azurerm_resource_group.terrform.location
  resource_group_name = azurerm_resource_group.terrform.name

  tags = local.common_tags
}

resource "azurerm_subnet" "janne_bastion" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = azurerm_resource_group.terrform.name
  virtual_network_name = azurerm_virtual_network.janne.name
  address_prefixes     = ["10.1.255.0/29"]

}

resource "azurerm_subnet" "janne_hosts" {
  name                 = "janne-linux-hosts"
  resource_group_name  = azurerm_resource_group.terrform.name
  virtual_network_name = azurerm_virtual_network.janne.name
  address_prefixes     = ["10.1.0.0/24"]
}

##########################
# Trefikflow
##########################


resource "azurerm_virtual_network_peering" "terraform" {
  name                      = "peer-${random_pet.project_name.id}-to-janne"
  resource_group_name       = azurerm_resource_group.terrform.name
  virtual_network_name      = azurerm_virtual_network.terraform.name
  remote_virtual_network_id = azurerm_virtual_network.janne.id
}

resource "azurerm_virtual_network_peering" "janne-pper" {
  name                      = "peer-janne-to-${random_pet.project_name.id}"
  resource_group_name       = azurerm_resource_group.terrform.name
  virtual_network_name      = azurerm_virtual_network.janne.name
  remote_virtual_network_id = azurerm_virtual_network.terraform.id
}

