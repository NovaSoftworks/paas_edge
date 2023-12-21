locals {
  component = "novacp-${var.environment}-${var.region_short}-nexus"
}

resource "azurerm_resource_group" "postgresql_rg" {
  name     = "${local.component}-postgresql-rg"
  location = var.region
}

resource "azurerm_postgresql_flexible_server" "postgresql" {
  name                   = "${local.component}-postgresql"
  resource_group_name    = azurerm_resource_group.postgresql_rg.name
  location               = azurerm_resource_group.postgresql_rg.location
  version                = "15"
  administrator_login    = var.postgresql_username
  administrator_password = var.postgresql_password
  storage_mb             = 32768
  sku_name               = var.postgresql_sku
  backup_retention_days  = 7
}
