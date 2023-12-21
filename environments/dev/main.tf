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

module "postgresql" {
  source = "../../modules/postgresql"

  environment  = var.environment
  region       = var.region
  region_short = var.region_short
}

module "redis" {
  source = "../../modules/redis"

  environment  = var.environment
  region       = var.region
  region_short = var.region_short
}