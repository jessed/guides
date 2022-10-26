terraform {
  required_providers {
    azurerm = { version = "~> 3.27.0" }
  }
}

provider "azurerm" {
  features {}
}

module "rg1" {
  source                = "./modules/resource_group"
  prefix                = format("%s-1-rg", var.prefix)
  location              = var.location
}

module "rg2" {
  source                = "./modules/resource_group"
  prefix                = format("%s-2-rg", var.prefix)
  location              = var.location
}
