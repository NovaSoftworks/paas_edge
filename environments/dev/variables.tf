variable "traefik_replicas" {
  type        = number
  description = "The number of replicas for the Traefik ingress controller."
}

variable "tls_issuer_email" {
  type        = string
  description = "The email address to use for the TLS certificates issuer."
}
