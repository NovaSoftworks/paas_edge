locals {
  component = "novacp-${var.environment}-${var.region_short}-vnet"
}

resource "azurerm_resource_group" "rg" {
  name     = "${local.component}-rg"
  location = var.region
}
