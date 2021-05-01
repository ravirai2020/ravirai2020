resource "azurerm_virtual_network" "virt_net" {
  count = length(var.VNET)
  resource_group_name = azurerm_resource_group.rg.name
  name = var.VNET[count.index].vnet_name
  location = azurerm_resource_group.rg.location
  address_space = var.VNET[count.index].address_space
  dynamic "subnet"{
    for_each = var.VNET[count.index].subnets
    content{
      name = subnet.value.name
      address_prefix = subnet.value.address
    }
  }

}
