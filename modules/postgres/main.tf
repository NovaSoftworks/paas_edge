locals {
  component = "novacp-${var.environment}-${var.region_short}-nexus"
}

resource "azurerm_resource_group" "postgres_rg" {
  name     = "${local.component}-postgres-rg"
  location = var.region
}

resource "azurerm_postgresql_flexible_server" "postgres" {
  name                   = "${local.component}-postgres"
  resource_group_name    = azurerm_resource_group.postgres_rg.name
  location               = azurerm_resource_group.postgres_rg.location
  version                = "15"
  administrator_login    = var.postgres_username
  administrator_password = var.postgres_password
  storage_mb             = 32768
  sku_name               = var.postgres_sku
  backup_retention_days  = 7

  private_dns_zone_id = var.dns_id
  delegated_subnet_id = var.postgres_subnet_id
}
