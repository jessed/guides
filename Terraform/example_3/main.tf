terraform {
  required_providers {
    azurerm = { version = "~> 3.27.0" }
  }
}

provider "azurerm" {
  features {}
}

module "rg" {
  source                = "./modules/resource_group"
  prefix                = var.prefix
  location              = var.location
}
