# Subnet
resource "azurerm_subnet" "jumpbox_subnet" {
  name                 = "jumpbox"
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = azurerm_resource_group.vnet_rg.name
  address_prefixes     = ["10.10.10.0/24"]
}

output "jumpbox_subnet_id" {
  value       = azurerm_subnet.jumpbox_subnet.id
  description = "The ID of the subnet to which the Jumpbox will be connected."
}
