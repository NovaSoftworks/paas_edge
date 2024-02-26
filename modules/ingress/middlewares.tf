resource "kubernetes_manifest" "ingress_middleware_redirect_to_https" {
  manifest = {
    apiVersion = "traefik.containo.us/v1alpha1"
    kind       = "Middleware"
    metadata = {
      name = "redirect-to-https"
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
    apiVersion = "traefik.containo.us/v1alpha1"
    kind       = "Middleware"
    metadata = {
      name = "redirect-to-non-www"
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
