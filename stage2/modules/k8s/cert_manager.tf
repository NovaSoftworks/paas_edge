resource "kubernetes_namespace" "cert_manager" {
  metadata {
    name = "cert-manager"
    labels = {
      "name" = "cert-manager"
    }
  }
}

resource "helm_release" "k8s_cert_manager" {
  name       = "cert-manager"
  namespace  = kubernetes_namespace.cert_manager.metadata.0.name
  repository = "https://charts.jetstack.io"
  chart      = "jetstack/cert-manager"

  set {
    name  = "installCRDs"
    value = "true"
  }
}
