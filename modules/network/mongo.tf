resource "azurerm_private_dns_zone" "mongo_dns" {
  name                = "privatelink.mongo.cosmos.azure.com"
  resource_group_name = azurerm_resource_group.vnet_rg.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "mongo_dns_link" {
  name                  = "novacp-${var.environment}-${var.region_short}-nexus-mongo-dns-link"
  private_dns_zone_name = azurerm_private_dns_zone.mongo_dns.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
  resource_group_name   = azurerm_resource_group.vnet_rg.name
}

resource "azurerm_subnet" "mongo_subnet" {
  name                 = "mongo"
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = azurerm_resource_group.vnet_rg.name
  address_prefixes     = ["10.42.2.0/24"]
}

output "mongo_dns_id" {
  value       = azurerm_private_dns_zone.mongo_dns.id
  description = "The ID of the Private DNS zone for MongoDB."
}

output "mongo_subnet_id" {
  value       = azurerm_subnet.mongo_subnet.id
  description = "The ID of the subnet to which MongoDB will be connected."
}
