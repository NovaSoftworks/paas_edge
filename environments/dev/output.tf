output "k8s" {
  value       = module.k8s.k8s
  description = "The Kubernetes cluster."
}

output "mongo" {
  value       = module.mongo.mongo
  description = "The MongoDB account."
}

output "postgres" {
  value       = module.postgres.postgres
  description = "The PostgreSQL server."
}
