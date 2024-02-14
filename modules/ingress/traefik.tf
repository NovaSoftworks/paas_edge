resource "kubernetes_namespace" "traefik" {
  metadata {
    name = "traefik"
    labels = {
      "name" = "traefik"
    }
  }
}

resource "helm_release" "k8s_traefik" {
  name       = "traefik"
  namespace  = kubernetes_namespace.traefik.metadata.0.name
  repository = "https://traefik.github.io/charts"
  chart      = "traefik"
  version    = "26.0.0"

  set {
    name  = "deployment.replicas"
    value = var.traefik_replicas
  }

  depends_on = [
    kubernetes_namespace.traefik
  ]
}
