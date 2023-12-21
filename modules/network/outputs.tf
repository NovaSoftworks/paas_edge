output "postgres_subnet_id" {
  value       = azurerm_subnet.postgres_subnet.id
  description = "The ID of the subnet to which the PostgreSQL server will be connected"
}
