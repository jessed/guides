=========
Modules
=========
A Terraform `Module <https://www.terraform.io/docs/glossary#module>`_ is a collection of Terraform `Configurations <https://www.terraform.io/docs/glossary#terraform-configuration>`_ that manage a particular type of infrastructure resource. For example, you may write a module to configure an Azure Resource-Group, or a module to provide configure the virtual-network and subnets that a BIG-IP is deployed to. For example, you may have a module called "virtual_network" that configures an Azure Virtual Network, then call that same module to create a client network, server network, and BIG-IP network. The code to create a virtual-network is only written once, as a module, but then executed multiple times with different input variables.

Modules are to Terraform what library files are to programming languages. They allow you to configure one or more elements, and then can be re-used multiple times in the same Terraform Run to configure those elements multiple times.

Demonstrating Terraform Modules is beyond the scope of this guide, but I may add a simple example if there is demand.

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

.. _NEXT: Runs.rst
.. _BACK: Resources.rst
.. _HOME: Index.rst

`NEXT`_

`BACK`_

`HOME`_