locals {
  component = "novacp-${var.environment}-${var.region_short}-nexus"
}

resource "azurerm_resource_group" "mongo_rg" {
  name     = "${local.component}-mongo-rg"
  location = var.region
}

resource "azurerm_private_endpoint" "cosmosdb" {
  name                = "novacp-${var.environment}-${var.region_short}-nexus-mongo-pe"
  location            = azurerm_resource_group.mongo_rg.location
  resource_group_name = azurerm_resource_group.mongo_rg.name
  subnet_id           = var.mongo_subnet_id

  private_service_connection {
    name                           = "novacp-${var.environment}-${var.region_short}-nexus-mongo-private-connection"
    private_connection_resource_id = azurerm_cosmosdb_account.mongo.id
    subresource_names              = ["MongoDB"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "novacp-${var.environment}-${var.region_short}-nexus-mongo-dns-zone-group"
    private_dns_zone_ids = [var.mongo_dns_id]
  }
}


resource "azurerm_cosmosdb_account" "mongo" {
  name                = "${local.component}-mongo"
  resource_group_name = azurerm_resource_group.mongo_rg.name
  location            = azurerm_resource_group.mongo_rg.location
  offer_type          = "Standard"
  kind                = "MongoDB"

  enable_automatic_failover = false

  enable_free_tier = true
  capacity {
    total_throughput_limit = 1000
  }

  consistency_policy {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 5
    max_staleness_prefix    = 100
  }

  geo_location {
    location          = azurerm_resource_group.mongo_rg.location
    failover_priority = 0
  }
}

resource "azurerm_cosmosdb_mongo_database" "mongo_test_db" {
  name                = "${local.component}-mongo-test-db"
  resource_group_name = azurerm_resource_group.mongo_rg.name
  account_name        = azurerm_cosmosdb_account.mongo.name
  throughput          = 1000
}
