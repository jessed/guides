=========
Resources
=========

Overview
========

A Terraform `Resource <https://www.terraform.io/docs/glossary#resource>`_ is a block that describes an infrastructure object. For example, you may have a "resource" that describes a virtual-machine in Azure. The resource would describe everything about that VM, like the number of CPU cores, amount of memory, disk size, and number of interfaces. Terraform will send that resource definition to the appropriate `Provider <https://www.terraform.io/docs/glossary#terraform-provider>`_ so that the described object can be created.

Example
===========
Here is a very simple example of a Resource block:
::

    resource "aws_instance" "web" {
      ami           = "ami-a1b2c3d4"
      instance_type = "t2.micro"
    }

Official Documentation
======================
The official Terraform documentation for Resource blocks can be found `here <https://developer.hashicorp.com/terraform/language/resources/syntax>`_

Resources are easily the most common element of Terraform configuration object. All of the resources supported by a particular provider are described in the provider documentation. For example, here is the documentation for the `azurerm_linux_virtual_machine <https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine>`_ resource.

**Note**: If you review that documentation you'll notice that the example near the top starts with the creation of the a virtual-network, then a subnet, then an interface, and *finally* an example of the resource we are actually talking about. This is a fairly common theme in Terraform documentation. It is very common for Terraform examples to include every other resource required by the object in question.


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

.. _NEXT: Modules.html
.. _BACK: Configurations.html
.. _HOME: Index.html

`NEXT`_

`BACK`_

`HOME`_
