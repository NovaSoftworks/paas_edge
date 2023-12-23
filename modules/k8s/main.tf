locals {
  component = "novacp-${var.environment}-${var.region_short}-nexus"
}

resource "azurerm_resource_group" "k8s_rg" {
  name     = "${local.component}-k8s-rg"
  location = var.region
}

resource "azurerm_kubernetes_cluster" "k8s" {
  name                = "${local.component}-k8s"
  resource_group_name = azurerm_resource_group.k8s_rg.name
  location            = azurerm_resource_group.k8s_rg.location
  dns_prefix          = "dns-k8s-nexus-${var.region_short}-${var.environment}-novacp"
  sku_tier            = var.k8s_sku_tier

  identity {
    type = "SystemAssigned"
  }

  default_node_pool {
    name            = "default"
    node_count      = var.k8s_node_count
    vm_size         = var.k8s_vm_size
    vnet_subnet_id  = var.k8s_subnet_id
    os_disk_size_gb = 30
  }

  network_profile {
    network_plugin    = "azure"
    load_balancer_sku = "standard"
  }
}
