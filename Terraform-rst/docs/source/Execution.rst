=========
Execution: Plan, Apply, Destroy
=========
`terraform plan <https://www.terraform.io/cli/commands/plan>`_ is used to perform an exhaustive check of your code, very similar to a 'dry-run' option. It will check the syntax, variable assignments, and attempt to identify circular references. <Circular references are when one resource depends on another, but that other object depends on the first one. Sometimes the dependency chain can include three or four objects, making identification of the circular reference difficult.>`_

Performing a `terraform plan` is always recommended prior to actually applying the configuration, and will most likely become an internalized part of your deployment process.

`terraform apply <https://www.terraform.io/cli/commands/apply>`_ is used to actually apply your configuration. It goes through the same process as `terraform plan <https://www.terraform.io/cli/commands/plan>`_, but this time the changes are actually implemented. As the 'apply' is executed Terraform will be writing completed actions to the 'terraform.state' file. The 'terraform.state' file contains `state <https://www.terraform.io/language/state>`_ information about the current, successfully-deployed configuration. Only resources that are *successfully* deployed are written to the state file. This file is then used for if Terraform is called again to compare the current deployment with a changed configuration to determine what it actually has to do.

For example, if you deployed a BIG-IP and a server in a previous 'terraform apply', then change something about the server configuration, Terraform will use the 'terraform.state' file to determine what it actually needs to do to make the deployed configuration match your IaC configuration. If the change to the servers configuration in Terraform doesn't impact the BIG-IP, then the server would be redeployed with the new configuration while the BIG-IP wouldn't be modified.

`terraform destroy <https://www.terraform.io/cli/commands/destroy>`_ is used to destroy/delete resources that have been deployed. The 'destroy' command will use the terraform.state file to remove objects in the opposite order of their deployment. The intent is to remove resources that have dependencies on other objects before attempting to remove those other objects. This process does work quite well, thoough it is not uncommon for an object in a public cloud to be 'marked for deletion' without having actually been deleted when Terraform attempts to delete the object it is dependent on. In these cases the 'destroy' operation will fail and you will need to run 'terraform destroy' again.

The scenario above occurs frequently enough that when dealing with certain public clouds I start out by running 'terraform destroy --auto-approve' three times, separated by semicolons so that the second and third calls will be occur immediately. Calling 'terraform destroy' when nothing is deployed doesn't cause problems because the 'destroy' command updates the 'terraform.state' file as each resource is destroyed, so subsequent calls only act on resources that are still deployed.
::
      terraform destroy --auto-approve; terraform destroy --auto-approve; terraform destroy --auto-approve

With a Bash alias (see `Tips and Tricks`_) that command can be reduced to:
::
    tfda; tfda; tfda

**NOTE**: The 'terraform apply' and 'terraform destroy' commands both require interactive approval before actually making any changes. To bypass the interactive approval use the '--auto-approve' command-line argument as shown here:
::
    terraform apply --auto-approve
    terraform destroy --auto-approve


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

.. _NEXT: Tips_and_Tricks.rst
.. _BACK: Initialization.rst
.. _HOME: Index.rst

`NEXT`_

`BACK`_

`HOME`_