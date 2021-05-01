resource "azurerm_public_ip" "testip" {
  name = var.PUB_IP_NAME
  resource_group_name= azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  allocation_method = "Static"
  ip_version = "IPv4"
  sku = "standard"
}

resource "azurerm_network_security_group" "nsg" {
  name = var.NSG_NAME
  resource_group_name= azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
}

resource "azurerm_network_security_rule" "netrule" {
  resource_group_name = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.nsg.name
  #count = length(var.PORTS)
  #dynamic "security_rule"{
  count = length(var.PORTS)
    #for_each = var.PORTS
      name = "port-${var.PORTS[count.index].port}"
      direction = "Inbound"
      access = "Allow"
      protocol = "Tcp"
      priority = var.PORTS[count.index].priority
      destination_port_range = var.PORTS[count.index].port
      source_port_range = "*"
      source_address_prefix = "*"
      destination_address_prefix = "VirtualNetwork"
}

data "azurerm_virtual_network" "net_detail_ip" {
  count = length(var.VNET)
  name                = azurerm_virtual_network.virt_net[count.index].name
  resource_group_name = var.RG_NAME
}

data "azurerm_subnet" "sub_detail_ip" {
  count = length(var.VNET)
  #name                 = data.azurerm_virtual_network.net_detail_ip[count.index].subnets[0]
  name                 = var.VNET[count.index].subnets[0].name
  virtual_network_name = azurerm_virtual_network.virt_net[count.index].name
  resource_group_name  = var.RG_NAME
}


resource "azurerm_subnet_network_security_group_association" "nsg_subnet" {
    count = length(var.VNET)
    #subnet_id = azurerm_virtual_network.virt_net[count.index].subnet[0]
    subnet_id = data.azurerm_subnet.sub_detail_ip[count.index].id
    network_security_group_id = azurerm_network_security_group.nsg.id

}
