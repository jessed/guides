# Example #3 - module creation and usage
**NOTE**: Executing this module will create an Azure Resource-Group

The following example illustrates the Terraform code:
1. Usage of the 'vars.tf', 'outputs.tf', and 'main.tf' as separate files
2. Usage of the Azure provider
3. Creation and usage of a module

Typically Terraform Runs use separate files for input variables, configuration blocks, and output blocks. Modules are defined in a sub-directories beneath the main Terraform directory. That directory structure, as well as the separate files, are demonstrated in this example.

The file and directory structure typically follows the pattern shown here:
```
    .
    | main.tf
    | vars.tf
    | outputs.tf
    |--modules
    |
    |  |--resource_group
    |  |   main.tf
    |  |   variables.tf
    |  |   outputs.tf
    |
    |  |--module1
    |  |   main.tf
    |  |   variables.tf
    |  |   outputs.tf
```

In this example we are creating a single module called *resource_group*. We are calling the *resource_group* module to create an Azure resource-group. Creating a resource-group in Azure reuqires a couple variables, specifically, a name and a location. These variables are passed to the module when it is called using variable assignments specified in *main.tf*. Those variables are also defined in the *variables.tf* file located within the module sub-directory.

The ./modules/resource_group/variables.tf file defines the input variables required by the module. All of the variables defined in the modules *variables.tf* file must be provided when the module is called from main.tf. If a variable is defined in the ./modules/*module*/variables.tf file and it is *not* provided when the module is called you will receive an error when running terraform [plan|apply].

***Note***: Additional variables can be provided to the module when it is called even without being defined in the variables.tf file; however, any additional variables will not be available for use. They simply don't cause a syntax error.

## ./vars.tf
    variable "prefix"     { default = "my_lab" }
    variable "location"   { default = "westus2" }

## ./main.tf
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

## ./outputs.tf
    output "rg" {
      description = "Resource group details"
      value = {
        rg_name     = module.rg.out.name
        rg_location = module.rg.out.location
        rg_id       = module.rg.out.id
      }
    

## ./modules/resource_group/variables.tf
		variable prefix     {}
		variable location   {}

## ./modules/resource_group/main.tf
    resource "azurerm_resource_group" "rg" {
      name      = var.prefix
      location  = var.location
    }

## ./modules/resource_group/outputs.tf
		output "out" { value = azurerm_resource_group.rg }
