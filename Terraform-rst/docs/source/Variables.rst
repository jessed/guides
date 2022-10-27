=========
Variables
=========

`Variables <https://www.terraform.io/language/values/variables>`_ are just that. They are provided to the various `Configurations <https://www.terraform.io/docs/glossary#terraform-configuration>`_ in lieu of static values to allow for simpler description of what should be deployed. That said, Variables in Terraform are a source of frequent confusion and much gnashing of teeth.

There are two basic types of varibales: `Input Variables <https://www.terraform.io/language/values/variables>`_ and `Local Values <https://www.terraform.io/language/values/locals>`_.

Input Variables
===============
`Input variables <https://www.terraform.io/language/values/variables>`_ are provided via configuration files, on the CLI, or pulled from environment variables. These are immutable (i.e. cannot be changed once defined), and they are defined when Terraform is executed. Dynamic values cannot be used, nor can one input variable receive its value from another input variable. These are static, immutable, and defined at run-time.

Local Values
============
`Local values <https://www.terraform.io/language/values/locals>`_ are also immutable, however these can receive dynamically generated values rather than static values. Unlike Input variables, local values can use other variables as part of the value.

Variable Usage
==============
Here is a simple example illustrating the defintion of both:
::

    variable "prefix" { default = "my_prefix" }
    locals { vnet_name = "${var.prefix}-vnet" }

The variable "prefix" would contain the value *my_prefix*, and the local value "vnet_name" would contain the value *my_prefix-vnet*. However, you would *not* be able to define input variable that leverage the existing value of the *prefix* variable.

    Tip: All Input variable names are referenced using the 'var.' prefix, and all local values are referenced using the 'local.' prefix.

Defining Variables
==================
The number of variables in a moderately complex Terraform Configuration can be quite large. For this reason there are several methods of breaking up your variables into different files. The benefit of this approach is that you can isolate the variables that apply to one group of objects in their own file, making it easier to find them if/when you decide to change something.

By default Terraform will source certain files for variable definitions:
* vars.tf
* variables.tf
* terraform.tfvars
* terraform.tfvars.json

Additional files can be specified on the CLI using the \*-var-file* option as shown here:
::

    terraform apply -var-file="my_variables.tfvars"

That syntax applies to files with the following extensions:
* .tfvars
* .tfvars.json

To simplify the import of additional variable files you can insert ".auto" between the filename and the ".tfvars" or ".tfvars.json" extension. Naming them this way removes the need to specify the filenames using the '-var-file' CLI option.

**Important Take-away**

The names of variables defined in \*.tfvars or \*.auto.tfvars files must be pre-defined in one of the automatic variable files. For example, if I have a variable called "bigip" in a file called "v_bigip.auto.tfvars", an empty "placeholder" variable defining that name must be located in one of the files that is imported automatically. Here is an example of how I would import a variable file called "v_bigip.auto.tfvars" containing a variable called "bigip":

**vars.tf**
::

    variable "bigip"   {}

**v_bigip.auto.tfvars**
::

    bigip = {
      name   = "my_ltm_01"
    }

Terraform would recognize a variable called "bigip" containing a nested variable called "use_paygo" with a string value of "my_ltm_01". If the placeholder variable is not present the variable(s)`_ within the v_bigip.auto.tfvars file would not be included. You would also get a runtime error when Terraform attempts to import the variables define in the "v_bigip.auto.tfvars" file.

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

.. _NEXT: Initialization.html
.. _BACK: Runs.html
.. _HOME: Index.html

`NEXT`_

`BACK`_

`HOME`_

