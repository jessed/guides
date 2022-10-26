=========
Example #1 - Simple variables and output
=========
The following example shows the Terraform code to:

#. Define an input variable called 'prefix'
#. Create a local value called 'rg_name' that incorporates the value of the 'prefix' variable
#. Create a `null-resource <https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource>`_ to call the command-line 'echo' command to print the values of the variable and local value
#. Create Terraform Output blocks that show the values of the variable and the local value

::

    variable "prefix" {
      default = "ProjectName"
    }
    
    locals {
      rg_name = "${var.prefix}-RG"
    }
    
    resource "null_resource" "call_echo" {
      provisioner "local-exec" {
        command = "echo \"The object prefix is ${var.prefix} and the rg_name is ${local.rg_name}\""
      }
    }
    
    output "prefix_name" {
      value = var.prefix
    }
    
    output "object_name" {
      value = local.rg_name
    }

**NOTE**: Terraform Runs that only involve built-in providers like *null-resource* do not require *terraform* or *provider* blocks. This makes it very easy to create trivial runs for the purpose of testing Terraform syntax and behavior. The example above was something I wrote when I first started using Terraform to test the use of a `null-resource`_.

--------------
Lab
--------------
Now we're going to run through the one and only lab including with this beginners guide. This is simply to demonstrate the expected output of each of the main terraform commands that you'll use when creating yoru own Runs.  To run this example you can either use the code in the ./example_1/ directory, which matches the example above, or create a new directory and copy/paste the example above into a file called *main.tf*. 

terraform init
--------------
In the directory with the *main.tf*, initialize Terraform:
::

    terraform init

Once that command completes you'll have a new hidden directory and a new hidden file:
::

    $ ls -lA
    total 16
    drwxr-xr-x@ 3 driskill  1437522721    96 Oct 26 15:21 .terraform
    -rw-r--r--@ 1 driskill  1437522721  1152 Oct 26 15:21 .terraform.lock.hcl
    -rw-r--r--@ 1 driskill  1437522721   359 Oct 15 11:53 main.tf

terraform plan
--------------
Now we'll run the 'terrform plan'. Technically this is an optional step as the 'terraform apply' will go through the same process out of necessity; however, finding problems *before* you starting deploying resources is always better. For that reason I recommend running 'terraform plan' prior to every 'terraform apply'.

::

    terraform plan

The output of the 'terraform plan' command will show everything Terraform will attempt to do when you run the 'apply'. Dynamic values will be replaced with placeholders that say 'known at apply'. Here is the output from the above 'terraform plan' operation:
::

    Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the
    following symbols:
      + create
    
    Terraform will perform the following actions:
    
      # null_resource.call_echo will be created
      + resource "null_resource" "call_echo" {
          + id = (known after apply)
        }
    
    Plan: 1 to add, 0 to change, 0 to destroy.
    
    Changes to Outputs:
      + object_name = "ProjectName-RG"
      + prefix_name = "ProjectName"

terraform apply
---------------
And finally we will run 'terraform apply'. Optionally you can add the '--auto-approve' argument to avoid the standard manual approval:
::

    terraform apply --auto-approve

Here is the output of the 'apply' command:
::

    $ terraform apply --auto-approve

    Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the
    following symbols:
      + create
    
    Terraform will perform the following actions:
    
      # null_resource.call_echo will be created
      + resource "null_resource" "call_echo" {
          + id = (known after apply)
        }
    
    Plan: 1 to add, 0 to change, 0 to destroy.
    
    Changes to Outputs:
      + object_name = "ProjectName-RG"
      + prefix_name = "ProjectName"
    null_resource.call_echo: Creating...
    null_resource.call_echo: Provisioning with 'local-exec'...
    null_resource.call_echo (local-exec): Executing: ["/bin/sh" "-c" "echo \"The object prefix is ProjectName and the rg_name is ProjectName-RG\""]
    null_resource.call_echo (local-exec): The object prefix is ProjectName and the rg_name is ProjectName-RG
    null_resource.call_echo: Creation complete after 0s [id=5577006791947779410]
    
    Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
    
    Outputs:
    
    object_name = "ProjectName-RG"
    prefix_name = "ProjectName"

You'll also find a new file in the directory called *terraform.state*. As promised, this is a JSON-formatted text file containing everything Terraform knows about the current deployment. We are only creating a variable, a local value, and a null-resource so this state file is quite small; however, the size grows very quickly once you start working with multi-resource Runs.

At this point you can inspect the various resources Terraform created using the 'terraform state list' and 'terraform state show <name>' commands:
::

    $ terraform state list
    null_resource.call_echo
    $ terraform state show null_resource.call_echo
    # null_resource.call_echo:
    resource "null_resource" "call_echo" {
        id = "5577006791947779410"
    }

terraform destroy
-----------------
Finally, we're going to 'destroy' the Resources created by this run with the 'terraform destroy' command. Like the 'terraform apply' command, the 'terraform --destroy' command supports the '--auto-approve' command-line argument:
::

    $ terraform destroy --auto-approve
    null_resource.call_echo: Refreshing state... [id=5577006791947779410]
    
    Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the
    following symbols:
      - destroy
    
    Terraform will perform the following actions:
    
      # null_resource.call_echo will be destroyed
      - resource "null_resource" "call_echo" {
          - id = "5577006791947779410" -> null
        }
    
    Plan: 0 to add, 0 to change, 1 to destroy.
    
    Changes to Outputs:
      - object_name = "ProjectName-RG" -> null
      - prefix_name = "ProjectName" -> null
    null_resource.call_echo: Destroying... [id=5577006791947779410]
    null_resource.call_echo: Destruction complete after 0s
    
    Destroy complete! Resources: 1 destroyed.

If you look in the directory now you'll see that the 'terraform.state' file is smaller, which is because we have no more created resources. You'll also notice a new file called 'terraform.state.backup'. The *terraform.state.backup* file is a copy of the 'terraform.state' file created immediately before any changes were made.




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

.. _NEXT: example_2.rst
.. _BACK: Tips_and_Tricks.rst
.. _HOME: Index.rst

`NEXT`_

`BACK`_

`HOME`_