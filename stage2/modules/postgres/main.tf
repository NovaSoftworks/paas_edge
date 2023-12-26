resource "azurerm_postgresql_flexible_server_database" "auth_db" {
  name      = "nexus_auth"
  server_id = var.postgres_id
  collation = "en_US.utf8"
  charset   = "UTF8"
}
