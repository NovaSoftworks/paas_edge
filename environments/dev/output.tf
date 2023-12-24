output "k8s" {
  value       = azurerm_kubernetes_cluster.k8s
  description = "The Kubernetes cluster."
}

output "mongo" {
  value       = azurerm_cosmosdb_account.mongo
  description = "The MongoDB account."
}

output "postgres" {
  value       = azurerm_postgresql_flexible_server.postgres
  description = "The PostgreSQL server."
}
