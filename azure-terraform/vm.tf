resource "azurerm_linux_virtual_machine" "testvm" {
  name = var.VM_NAME
  resource_group_name = var.RG_NAME
  admin_username = var.ADMIN_USER
  location = var.RG_LOCATION
  size = var.VM_SIZE
  source_image_reference{
    publisher = "Canonical"
    offer = "UbuntuServer"
    sku = "18.04-LTS"
    version = "latest"
  }
  admin_ssh_key{
    public_key = azurerm_ssh_public_key.example.public_key
    username = var.ADMIN_USER
  }
  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]
  os_disk {
      caching              = "ReadWrite"
      storage_account_type = "Standard_LRS"
    }
}

data "azurerm_virtual_network" "net_detail" {
  name                = azurerm_virtual_network.virt_net[1].name
  resource_group_name = var.RG_NAME
}

data "azurerm_subnet" "sub_detail" {
  name                 = data.azurerm_virtual_network.net_detail.subnets[1]
  virtual_network_name = azurerm_virtual_network.virt_net[1].name
  resource_group_name  = var.RG_NAME
}


resource "azurerm_network_interface" "nic" {
  name = "test-nic"
  location = var.RG_LOCATION
  resource_group_name = var.RG_NAME
  ip_configuration {
    name                          = "nic1"
    subnet_id                     = data.azurerm_subnet.sub_detail.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.testip.id
  }

}
