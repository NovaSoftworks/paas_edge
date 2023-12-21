locals {
  component = "novacp-${var.environment}-${var.region_short}-nexus"
}

resource "azurerm_resource_group" "redis_rg" {
  name     = "${local.component}-redis-rg"
  location = var.region
}
