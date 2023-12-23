resource "azurerm_subnet" "k8s_subnet" {
  name                 = "k8s"
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = azurerm_resource_group.vnet_rg.name
  address_prefixes     = ["10.0.0.0/16"]
}
