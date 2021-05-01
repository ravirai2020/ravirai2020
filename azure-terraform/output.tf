output "resource_group" {
  value = azurerm_resource_group.rg.id
}

data "azurerm_subscription" "current"{}

output "subscription" {
  value = data.azurerm_subscription.current.display_name
}

output "public_ip"{
  value = azurerm_public_ip.testip.ip_address
}

output "subnet_list"{
  value = tolist(azurerm_virtual_network.virt_net)[*].subnet
}
