resource "kubernetes_namespace" "k8_auth_namespace" {
  metadata {
    name = "auth"
  }
}

resource "kubernetes_namespace" "k8_frontend_namespace" {
  metadata {
    name = "frontend"
  }
}

resource "kubernetes_namespace" "k8s_backend_namespace" {
  metadata {
    name = "backend"
  }
}
