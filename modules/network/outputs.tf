output "dns_id" {
  value       = azurerm_private_dns_zone.dns.id
  description = "The ID of the Private DNS zone for the Nexus virtual network"
}

output "postgres_subnet_id" {
  value       = azurerm_subnet.postgres_subnet.id
  description = "The ID of the subnet to which the PostgreSQL server will be connected"
}
