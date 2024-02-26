resource "kubernetes_manifest" "cert_issuer_le_http" {
  manifest = {
    apiVersion = "cert-manager.io/v1"
    kind       = "Issuer"
    metadata = {
      name      = "le-http"
      namespace = kubernetes_namespace.cert_manager.metadata.0.name
    }
    spec = {
      acme = {
        email = var.issuer_email
        privateKeySecretRef = {
          name = "issuer-account-key"
        }
        server = "https://acme-v02.api.letsencrypt.org/directory"
        solvers = [
          {
            http01 = {
              ingress = {
                class = "traefik"
              }
            }
          }
        ]
      }
    }
  }
}
