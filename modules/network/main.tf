locals {
  component = "novacp-${var.environment}-${var.region_short}-nexus-vnet"
}

resource "azurerm_resource_group" "vnet_rg" {
  name     = "${local.component}-rg"
  location = var.region
}

resource "azurerm_virtual_network" "vnet" {
  name                = local.component
  location            = azurerm_resource_group.vnet_rg.location
  resource_group_name = azurerm_resource_group.vnet_rg.name
  address_space       = ["10.0.0.0/8"]
}

resource "azurerm_private_dns_zone" "dns" {
  name                = "${var.environment}.${var.region_short}.nexus.novasoftworks.net"
  resource_group_name = azurerm_resource_group.vnet_rg.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "example" {
  name                  = "${local.component}-dns-link"
  private_dns_zone_name = azurerm_private_dns_zone.dns.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
  resource_group_name   = azurerm_resource_group.vnet_rg.name
}

resource "azurerm_subnet" "postgres_subnet" {
  name                 = "postgres"
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = azurerm_resource_group.vnet_rg.name
  address_prefixes     = ["10.10.0.0/24"]

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

resource "azurerm_subnet" "redis_subnet" {
  name                 = "redis"
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = azurerm_resource_group.vnet_rg.name
  address_prefixes     = ["10.10.1.0/24"]
}
