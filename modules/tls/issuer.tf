resource "kubernetes_manifest" "cert_issuer_le_http" {
  manifest = {
    apiVersion = "cert-manager.io/v1"
    kind       = "ClusterIssuer"
    metadata = {
      name = "le-http"
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
