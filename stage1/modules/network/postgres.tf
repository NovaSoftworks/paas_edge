resource "azurerm_private_dns_zone" "postgres_dns" {
  name                = "privatelink.postgres.database.azure.com"
  resource_group_name = azurerm_resource_group.vnet_rg.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "postgres_dns_link" {
  name                  = "novacp-${var.environment}-${var.region_short}-nexus-postgres-dns-link"
  private_dns_zone_name = azurerm_private_dns_zone.postgres_dns.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
  resource_group_name   = azurerm_resource_group.vnet_rg.name
}

resource "azurerm_subnet" "postgres_subnet" {
  name                 = "postgres"
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = azurerm_resource_group.vnet_rg.name
  address_prefixes     = ["10.42.1.0/24"]

  delegation {
    name = "fs"

    service_delegation {
      name = "Microsoft.DBforPostgreSQL/flexibleServers"

      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
      ]
    }
  }
}

output "postgres_dns_id" {
  value       = azurerm_private_dns_zone.postgres_dns.id
  description = "The ID of the Private DNS zone for PostgreSQL"
}

output "postgres_subnet_id" {
  value       = azurerm_subnet.postgres_subnet.id
  description = "The ID of the subnet to which the PostgreSQL server will be connected"
}
