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
  infra = data.terraform_remote_state.infrastructure.outputs
}

provider "kubernetes" {
  host                   = local.infra.paas_k8s_host
  client_certificate     = local.infra.paas_k8s_client_certificate
  client_key             = local.infra.paas_k8s_client_key
  cluster_ca_certificate = local.infra.paas_k8s_cluster_ca_certificate

}

provider "helm" {
  kubernetes {
    host                   = local.infra.paas_k8s_host
    client_certificate     = local.infra.paas_k8s_client_certificate
    client_key             = local.infra.paas_k8s_client_key
    cluster_ca_certificate = local.infra.paas_k8s_cluster_ca_certificate
  }
}

module "tls" {
  source = "../../modules/tls"

  issuer_email = var.tls_issuer_email
}

module "ingress" {
  source = "../../modules/ingress"

  traefik_replicas = var.traefik_replicas
}
