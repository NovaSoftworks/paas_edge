locals {
  component = "novacp-${var.environment}-${var.region_short}-nexus"
}

resource "azurerm_resource_group" "rg" {
  name     = "${local.component}-redis-rg"
  location = var.region
}
