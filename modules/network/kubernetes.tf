resource "azurerm_subnet" "kubernetes_subnet" {
  name                 = "kubernetes"
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = azurerm_resource_group.vnet_rg.name
  address_prefixes     = ["10.0.0.0/16"]
}
