resource "azurerm_network_interface" "janne_nic" {
  name                = "janne-pc-nic"
  location            = var.location
  resource_group_name = azurerm_resource_group.terrform.name

  ip_configuration {
    name                          = "janne-internal"
    subnet_id                     = azurerm_subnet.janne_hosts.id
    private_ip_address_allocation = "Dynamic"
  }

  tags = local.common_tags

}


resource "azurerm_linux_virtual_machine" "janne_linuxvm" {
  name                            = "janne-pc"
  resource_group_name             = azurerm_resource_group.terrform.name
  location                        = azurerm_resource_group.terrform.location
  size                            = "Standard_B1s"
  admin_username                  = var.vm_username
  admin_password                  = var.vm_password
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.janne_nic.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }
  tags = local.common_tags
}
