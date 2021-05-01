resource "azurerm_resource_group" "rg"{
  name = var.RG_NAME
  location = var.RG_LOCATION
}


resource "azurerm_ssh_public_key" "example"{
  name = "AZKey"
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  public_key = file("key_pub/AZKey.txt")
}
