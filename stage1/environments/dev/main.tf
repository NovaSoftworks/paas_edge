terraform {
  required_version = ">= 1.1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.2"
    }
  }
  cloud {
    organization = "NovaSoftworks"
    workspaces {
      name = "nexus-infrastructure-stage1-dev"
    }
  }
}

data "terraform_remote_state" "global" {
  backend = "remote"

  config = {
    organization = "NovaSoftworks"
    workspaces = {
      name = "global-infrastructure-dev"
    }
  }
}

provider "azurerm" {
  features {}
}

module "network" {
  source = "../../modules/network"

  environment  = var.environment
  region       = var.region
  region_short = var.region_short
}

module "jumpbox" {
  source     = "../../modules/jumpbox"
  depends_on = [module.network]

  environment  = var.environment
  region       = var.region
  region_short = var.region_short

  jumpbox_vm_size  = var.jumpbox_vm_size
  jumpbox_username = var.jumpbox_username
  jumpbox_password = var.jumpbox_password

  jumpbox_subnet_id = module.network.jumpbox_subnet_id
}

module "k8s" {
  source     = "../../modules/k8s"
  depends_on = [module.network]

  environment  = var.environment
  region       = var.region
  region_short = var.region_short

  k8s_sku_tier          = var.k8s_sku_tier
  k8s_system_vm_size    = var.k8s_system_vm_size
  k8s_system_node_count = var.k8s_system_node_count
  k8s_spot_vm_size      = var.k8s_spot_vm_size
  k8s_spot_node_count   = var.k8s_spot_node_count

  k8s_subnet_id = module.network.k8s_subnet_id

  acr_id = data.terraform_remote_state.global.outputs.acr.id
}
