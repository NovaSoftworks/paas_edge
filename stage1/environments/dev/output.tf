output "k8s" {
  value       = module.k8s.k8s
  description = "The Kubernetes cluster."
  sensitive   = true
}
