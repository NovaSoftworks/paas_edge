terraform {
  required_version = ">= 1.1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.2"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.24"
    }
  }
  cloud {
    organization = "NovaSoftworks"
    workspaces {
      name = "nexus-infrastructure-stage2-dev"
    }
  }
}

data "terraform_remote_state" "stage1" {
  backend = "remote"

  config = {
    organization = "NovaSoftworks"
    workspaces = {
      name = "nexus-infrastructure-stage1-dev"
    }
  }
}

provider "azurerm" {
  features {}
}

locals {
  kube_config = data.terraform_remote_state.stage1.outputs.k8s.kube_config.0
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

module "k8s" {
  source = "../../modules/k8s"
}

module "postgres" {
  source = "../../modules/postgres"

  postgres_id = data.terraform_remote_state.stage1.outputs.postgres.id
}
