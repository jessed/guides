=============
Configurations
=============
A Terraform `Configuration <https://www.terraform.io/docs/glossary#terraform-configuration>`_ is a block of code that *declaratively* describes how your infrastructure should be configured. In it's very simplest form a Terraform run can consist of only a single Configuration. A Terraform Run consists Configuration blocks; sometimes many, many configuration blocks. During the initialization process Terraform reads through all of the Configuration blocks and determines the dependency order, which dictates the order in which each configuration block is acted upon. Configuration blocks do not contain executable code, Terraform is not a programming language. That said, it is sometimes helpful to think of Configuration blocks as being the equivalent of commands in a programming language.

Here is a very simple example Configuration block that uses the `null_resource <https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource>`_ resource to call a command in bash:
::
    resource "null_resource" "test" {
      provisioner "local-exec" {
        command = "echo \"Hello world\""
      }
    }

In this examle the Configuration consists of a Resource of the type *null_resource*, but it just as easily could have been a call to a `Module <https://www.terraform.io/language/modules/develop>`_, as shown here:
::
    module "rg" {
      source                      = "./modules/resource_group"
      rg                          = local.rg
    }

Or an `Output <https://www.terraform.io/language/values/outputs>`_ block:
::
    output "my_out" {
      value  = "This is the output - user: ${local.data.admin_user}"
    }

Even a `Variable <https://www.terraform.io/language/values/variables>`_ are a type of configuration and defined in the same way:
::
    variable "prefix" {
      default = "my_prefix"
    }


Configuration blocks can become quite complex, as you'll see as soon as you take a look at the configuration for deploying a VM into any cloud. I'm not providing an example of a complex configuration block because that isn't a Day-1 topic, but if you are curious here is the documentation for the `azurerm_linux_virtual_machine <https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine>`_ resource in Azure. This example is just about as simple as it gets for deploying a VM in Azure.

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

.. _NEXT: Resources.rst
.. _BACK: Registry.rst
.. _HOME: Index.rst

`NEXT`_

`BACK`_

`HOME`_

