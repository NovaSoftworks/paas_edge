resource "azurerm_subnet" "mongo_subnet" {
  name                 = "mongo"
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = azurerm_resource_group.vnet_rg.name
  address_prefixes     = ["10.10.1.0/24"]
}

