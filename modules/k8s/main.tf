locals {
  component = "novacp-${var.environment}-${var.region_short}-nexus"
}

resource "azurerm_resource_group" "k8s_rg" {
  name     = "${local.component}-k8s-rg"
  location = var.region
}
