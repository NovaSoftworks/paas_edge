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
      name = "infrastructure-dev"
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
}

/*
module "postgres" {
  source     = "../../modules/postgres"
  depends_on = [module.network]

  environment  = var.environment
  region       = var.region
  region_short = var.region_short

  postgres_vm_size  = var.postgres_vm_size
  postgres_username = var.postgres_username
  postgres_password = var.postgres_password

  postgres_dns_id    = module.network.postgres_dns_id
  postgres_subnet_id = module.network.postgres_subnet_id
}

module "mongo" {
  source     = "../../modules/mongo"
  depends_on = [module.network]

  environment  = var.environment
  region       = var.region
  region_short = var.region_short

  mongo_dns_id    = module.network.mongo_dns_id
  mongo_subnet_id = module.network.mongo_subnet_id
}
*/
