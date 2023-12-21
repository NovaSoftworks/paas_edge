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

module "postgresql" {
  source     = "../../modules/postgresql"
  depends_on = [module.network]

  environment  = var.environment
  region       = var.region
  region_short = var.region_short

  postgresql_sku      = "B_Standard_B1ms"
  postgresql_username = var.postgresql_username
  postgresql_password = var.postgresql_password
}

module "redis" {
  source     = "../../modules/redis"
  depends_on = [module.network]

  environment  = var.environment
  region       = var.region
  region_short = var.region_short
}
