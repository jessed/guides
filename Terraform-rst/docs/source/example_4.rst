============================================================================
Example #4 - module usage with ternary conditional and 'count' meta-argument
============================================================================
**NOTE**: In order to execute this example you must have access to the Azure CLI and it must be authenticated to work with Azure.

**NOTE**: This example will create three Azure Resource-Groups called 'my_lab-1-rg', 'my_lab-2-rg', and so on.

The following example illustrates the Terraform code:
1. Usage of the 'vars.tf', 'outputs.tf', and 'main.tf' as separate files
2. Usage of the Azure provider
3. Creation and usage of a module

Typically Terraform Runs use separate files for input variables, configuration blocks, and output blocks. Modules are defined in a sub-directories beneath the main Terraform directory. That directory structure, as well as the separate files, are illustrated here:

The files and directory structure typically follow this pattern:
::

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

In this example we are using the *resource_group* module to create an arbitrary number of resource-groups using the `count <https://developer.hashicorp.com/terraform/language/meta-arguments/count>`_ meta-argument. The *instances* variable controls the number of resource-groups created; however, the 'single' variable controls whether the 'instances' variable is actually used. If the 'single' variable is set to 'true', then the number of resource-groups crated is only one.

Checking the value of the 'single' variable is done by the `ternary conditional <https://developer.hashicorp.com/terraform/language/expressions/conditionals>`_. The ternary conditional checks the value of a variable. If the condition is true, the first option following the '?' is assigned to the variable. If the condition is false then the option following the ':' is assigned. The basic syntax is as follows:
::

    variable = condition ? value_1 : value_2

The condition can be a simple comparison, as is shown in the example below, or it can be a compound comparison like so:
::

    variable = condition_1 && condition_2 ? value_1 : value_2


Notice that 'count' is *not* defined in the module variables.tf file. This is because 'count' is a meta-argument that applies to the module and is not provided to the module itself. Rather, it defines how many times the module is called. Also notice that the 'prefix' variable sent to the module is updated for each iteration using the 'count.index+1' syntax. This ensures that each resource-group has a unique name, but can be used in other ways.

./vars.tf
---------
::

    variable "prefix"     { default = "my_lab" }
    variable "location"   { default = "westus2" }
    variable "single"     { default = false }
    variable "instances   { default = 3 }

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
    
    module "rg" {
      source                = "./modules/resource_group"
      count                 = var.single == false ? var.instances : 1
      prefix                = format("%s-%d-rg", var.prefix, count.index+1)
      location              = var.location
    }

./outputs.tf
------------
::

    output "rg" {
      description = "Resource group details"
      value = {
        rg_name     = module.rg.*.out.name
        rg_location = module.rg.*.out.location
        rg_id       = module.rg.*.out.id
      }

./modules/resource_group/variables.tf
-------------------------------------
::

    variable prefix     {}
    variable location   {}

./modules/resource_group/main.tf
--------------------------------
::

    resource "azurerm_resource_group" "rg" {
      name      = var.prefix
      location  = var.location
    }

./modules/resource_group/outputs.tf
-----------------------------------
::

    output "out" { value = azurerm_resource_group.rg }


.. _Providers: Providers.rst
.. _Registry: Registry.rst
.. _Configurations: Configurations.rst
.. _Resources: Resources.rst
.. _Modules: Modules.rst
.. _Runs: Runs.rst
.. _Variables: Variables.rst
.. _Initialization: Initialization.rst
.. _Execution: Execution.rst
.. _Tips and Tricks: Tips_and_Tricks.rst
.. _Example 1: example_1.rst
.. _Example 2: example_2.rst
.. _Example 3: example_3.rst
.. _Example 4: example_4.rst

.. _BACK: example_3.rst
.. _HOME: Index.rst

`BACK`_

`HOME`_