output "k8s" {
  value       = module.k8s.k8s
  description = "The Kubernetes cluster."
  sensitive   = true
}

output "mongo" {
  value       = module.mongo.mongo
  description = "The MongoDB account."
  sensitive   = true
}

output "postgres" {
  value       = module.postgres.postgres
  description = "The PostgreSQL server."
  sensitive   = true
}
