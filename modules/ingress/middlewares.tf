resource "kubernetes_manifest" "ingress_middleware_redirect_to_https" {
  manifest = {
    apiVersion = "traefik.io/v1alpha1"
    kind       = "Middleware"
    metadata = {
      name      = "redirect-to-https"
      namespace = kubernetes_namespace.traefik.metadata.0.name
    }
    spec = {
      redirectScheme = {
        permanent = true
        scheme    = "https"
      }
    }
  }
}

resource "kubernetes_manifest" "ingress_middleware_redirect_to_non_www" {
  manifest = {
    apiVersion = "traefik.io/v1alpha1"
    kind       = "Middleware"
    metadata = {
      name      = "redirect-to-non-www"
      namespace = kubernetes_namespace.traefik.metadata.0.name
    }
    spec = {
      redirectRegex = {
        permanent   = true
        regex       = "^https?://www\\.(.*)"
        replacement = "https://$1"
      }
    }
  }
}
