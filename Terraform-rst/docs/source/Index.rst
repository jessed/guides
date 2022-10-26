==================================
Day 0 Beginners Guide to Terraform
==================================
------------
# Motivation
------------
The most frustrating aspect of Terraform is the "Day One" learning curve. When first starting out most of the examples I found (by which I mean: every single one), seemed to assume that you understand the basic operation of Terraform and focused on the more complex use-cases. The problem with that is that I held certain misconceptions that none of those guides actually addressed. The most significant one was "How do I download the package (provider) to interact with a specific service?". The answer is "You don't", but all of the guides I found seemed to assume that knowledge and didn't address the topic. In hindsight I understand why, but it's been over two years and I still remember the intense frustration of that first day working with Terraform (TF).

This guide is intended to answer those very basic beginner questions, as well as walk you through the creation of your first (extremely) simple Terraform Run so you can see how the various pieces for together.

------------
Organization
------------
This guide is broken into several small parts intended to let you skip the frustration of discovering them yourself. It definitely does not replace the `Terraform Documentation <https://www.terraform.io/intro>`_, but as you'll discover if you click the link, this guide will reduce the time you need to "internalize" how to use Terraform.

Sections 12-15 contains simple examples to illustrate how several Terraform concepts fit together. The code for each example is available not only on the example page, but in the corresponding .../example_*/ directory.

--------
Terrform
--------
As stated, this guide is a simple introduction to `Terraform <https://www.terraform.io/intro>`_, and we will be going over several of the basic elements of a basic Terraform deployment. Those elements are:

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

#. `tl;dr Quick Start`_
#. `Providers`_
#. `Registry`_
#. `Configurations`_
#. `Resources`_
#. `Modules`_
#. `Runs`_
#. `Variables`_
#. `Initialization`_
#. `Execution`_: Plan, Apply, Destroy
#. `Tips and Tricks`_
#. `Example 1`_
    * Variables, local values, null_resource resource, and outputs
#. `Example 2`_
    * Variables, local values with embedded values, outputs
#. `Example 3`_
    * Module creation and usage, module outputs
#. `Example 4`_
    * Module usage with ternary conditional and 'count' meta-argument

tl;dr Quick Start
-----------------
1. Write your Terraform code

   * I describe this below; however, if you are actually starting with this know that I have experienced your pain and have no sympathy. Helping you avoid that pain is the whole purpose of this guide.
2. ``terraform init``

   * Initialize your TF environment, which includes a basic syntax check.
   * NOTE: This will download the required providers and enumerate your modules.
3. ``terraform plan``

   * More thorough syntax check
   * Determine order of operations based on dependencies
   * Logic check - checks for unmet dependencies, circular logic, missing variables, etc...
4. ``terraform apply [--auto-approve]``

   * Deploy the configuration.
   * Communication/authentication/authorization issues will be caught at this stage.
   * Failures will *not* be rolled back automatically.
5. ``terraform destroy``

   * Destroy/delete deployed objects
   * Reverses the order of operations determined at the time of deployment

--------
Examples
--------

`Example 1`_
-----------
* Create variable
* Create local value using variable value
* Create *null_resource* to call a bash command
* Create Output blocks to print the values of the variable and local value

`Example 2`_
-----------
* Create variable
* Create local values containing several embedded values using the variable to build the names
* Create Output blocks to print the variable and local values

`Example 3`_
-----------
* Create and run a module that creates an Azure resource-group
* Create output blocks that print the values of the module

`Example 4`_
-----------
* Example usage of the ternary conditional and the `count <https://developer.hashicorp.com/terraform/language/meta-arguments/count>`_ meta-argument

.. _NEXT: Providers.rst
`NEXT`_