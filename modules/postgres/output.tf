output "postgres" {
  value       = azurerm_postgresql_flexible_server.postgres
  description = "The PostgreSQL server."
}
