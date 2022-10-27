========================================
Example #3 - module creation and usage
========================================
`Official Documentation <https://developer.hashicorp.com/terraform/tutorials/modules/module>`_

**NOTE**: In order to execute this example you must have access to the Azure CLI and it must be authenticated to work with Azure.

**NOTE**: This example will create two Azure Resource-Groups called 'my_lab-1-rg' and 'my_lab-2-rg'.

The following example illustrates the Terraform code:

1. Usage of the 'vars.tf', 'outputs.tf', and 'main.tf' as separate files
2. Usage of the Azure provider
3. Creation and usage of a module

Typically Terraform Runs use separate files for input variables, configuration blocks, and output blocks. Modules are defined in a sub-directories beneath the main Terraform directory. The typical directory structure, as well as the separate files, are illustrated here:
::

    .
    +-- main.tf
    +-- vars.tf
    +-- outputs.tf
    +-- modules
    |   +-- resource_group
    |      +-- main.tf
    |      +-- variables.tf
    |      +- -outputs.tf

In this example we are creating a single module called *resource_group*. We are calling the *resource_group* module to create an Azure resource-group. Creating a resource-group in Azure reuqires a couple variables, specifically, a name and a location. These variables are passed to the module when it is called using variable assignments specified in *main.tf*. Those variables are also defined in the *variables.tf* file located within the module sub-directory.

The ./modules/resource_group/variables.tf file defines the input variables required by the module. All of the variables defined in the modules *variables.tf* file must be provided when the module is called from main.tf. If a variable is defined in the ./modules/*<module>*/variables.tf file and it is *not* provided when the module is called you will receive an error when running terraform [plan|apply].

**Note**: Additional variables can be provided to the module when it is called even without being defined in the variables.tf file; however, any additional variables will not be available for use. They simply don't cause a syntax error.

./vars.tf
---------
::

    variable "prefix"     { default = "my_lab" }
    variable "location"   { default = "westus2" }


./main.tf
---------
::

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
      prefix                = var.prefix
      location              = var.location
    }
    module "rg2" {
      source                = "./modules/resource_group"
      prefix                = var.prefix
      location              = var.location
    }

./outputs.tf
------------
::

    output "rg1" {
      description = "Resource group details"
      value = {
        rg_name     = module.rg1.out.name
        rg_location = module.rg1.out.location
        rg_id       = module.rg1.out.id
      }
    }
    
    output "rg2" {
      description = "Resource group details"
      value = {
        rg_name     = module.rg2.out.name
        rg_location = module.rg2.out.location
        rg_id       = module.rg2.out.id
      }
    }

./modules/resource_group/variables.tf
-------------------------------------
::

    variable prefix     {}
    variable location   {}

The module variables.tf file defines the variables required by the module. These variables *must* be provided when the module is called. If variables are defined in the module variables.tf file but not provided when the module is called an error will be reported when you run terraform [plan|apply].

./modules/resource_group/main.tf
--------------------------------
::

    resource "azurerm_resource_group" "rg" {
      name      = var.prefix
      location  = var.location
    }

The module main.tf file defines the actions that will be taken by the module. The syntax is identical to the syntax defined in the primary main.tf; however, the only variables available are those defined in the module variables.tf file.

./modules/resource_group/outputs.tf
-----------------------------------
::

    output "out" { value = azurerm_resource_group.rg }

The module outputs.tf file sends the outputs back to the main terraform execution. These outputs can then be used as input variables to other configuration blocks, including other modules. They can also be used in output blocks defined in the main directory to print the values after the Terraform Run completes. One very common example of this is printing the IP addresses of virtual-machines instantiated by the Terraform Run.

.. _Providers: Providers.html
.. _Registry: Registry.html
.. _Configurations: Configurations.html
.. _Resources: Resources.html
.. _Modules: Modules.html
.. _Runs: Runs.html
.. _Variables: Variables.html
.. _Initialization: Initialization.html
.. _Execution: Execution.html
.. _Tips and Tricks: Tips_and_Tricks.html
.. _Example 1: example_1.html
.. _Example 2: example_2.html
.. _Example 3: example_3.html
.. _Example 4: example_4.html

.. _NEXT: example_4.html
.. _BACK: example_2.html
.. _HOME: Index.html

`NEXT`_

`BACK`_

`HOME`_
