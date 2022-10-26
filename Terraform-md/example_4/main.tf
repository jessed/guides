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
  count                 = var.single == false ? var.instances : 1
  prefix                = format("%s-%d-rg", var.prefix, count.index+1)
  location              = var.location
}

