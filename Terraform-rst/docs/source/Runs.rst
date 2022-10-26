=========
Run
=========
A Terraform `Run <https://www.terraform.io/docs/glossary#run>`_ consists of one or more `Resources <https://www.terraform.io/docs/glossary#resource>`_. Resources are what will actually happen when you enter `terraform apply` to deploy your configuration.

Terraform `Resources <https://www.terraform.io/docs/glossary#resource>`_ are blocks of Infrastructure-as-Code (IaC) elements. These define what the deployment *should* be and leave it up to the Terraform logic and the provider to make happen. While several aspects of Terraform seem quite similar to a programming language, what you are actually "coding" is how things should be. When you run `terraform apply`, you are telling Terraform to make them that way.


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

.. _NEXT: Variables.rst
.. _BACK: Modules.rst
.. _HOME: Index.rst

`NEXT`_

`BACK`_

`HOME`_