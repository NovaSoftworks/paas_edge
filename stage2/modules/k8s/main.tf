resource "kubernetes_namespace" "k8_auth_namespace" {
  metadata {
    name = "auth"
    labels = {
      "istio.io/rev" = "asm-1-17"
    }
  }
}

resource "kubernetes_namespace" "k8s_backend_namespace" {
  metadata {
    name = "backend"
    labels = {
      "istio.io/rev" = "asm-1-17"
    }
  }
}

resource "helm_release" "k8s_cert_manager" {
  name       = "cert-manager"
  namespace  = "cert-manager"
  repository = "https://charts.jetstack.io"
  chart      = "jetstack/cert-manager"

  create_namespace = true
  skip_crds        = false
}
