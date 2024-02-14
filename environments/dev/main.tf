terraform {
  required_version = ">= 1.1.0"
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.24"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.1.0"
    }
  }
  cloud {
    organization = "NovaSoftworks"
    workspaces {
      name = "paas-edge-dev"
    }
  }
}

provider "azurerm" {
  features {}
}

data "terraform_remote_state" "infrastructure" {
  backend = "remote"

  config = {
    organization = "NovaSoftworks"
    workspaces = {
      name = "infrastructure-dev"
    }
  }
}

locals {
  kube_config = data.terraform_remote_state.infrastructure.outputs.k8s.kube_config.0
}

provider "kubernetes" {
  host                   = local.kube_config.host
  client_certificate     = base64decode(local.kube_config.client_certificate)
  client_key             = base64decode(local.kube_config.client_key)
  cluster_ca_certificate = base64decode(local.kube_config.cluster_ca_certificate)

}

provider "helm" {
  kubernetes {
    host                   = local.kube_config.host
    client_certificate     = base64decode(local.kube_config.client_certificate)
    client_key             = base64decode(local.kube_config.client_key)
    cluster_ca_certificate = base64decode(local.kube_config.cluster_ca_certificate)
  }
}

module "tls" {
  source = "../../modules/tls"
}

module "ingress" {
  source = "../../modules/ingress"

  traefik_replicas = var.traefik_replicas
}
