===============
Tips and Tricks
===============
Terraform has a few execution quirks that can become bothersome with frequent usage. One example is that both 'terraform apply' and 'terraform destroy' require an interactive approval. Bypassing this is possible with the use of the '--auto-approve' argument, but that's a lot to be typing everytime you want to perform or clean-up a terraform run. (And, being exceptionally lazy, I don't want to be typing that much every time I run a terraform command.) So what follows are the Bash aliases I use with terraform, as well as a few other things I do to a) simplify terraform usage and b) diagnose problems with terraform runs.

#. :ref:`Bash aliases`
#. :ref:`Terraform State`
#. :ref:`Azure Terraform State Trick`
#. :ref:`Selective apply / destroy`
#. :ref:`Terraform State file manipulation`
#. :ref:`Using Terraform with Git`

Bash aliases
============
Bash aliases are a way to create Bash commands that call actual programs. Bash aliases are defined as so:
::

    alias alias_name="command_to_run <arguments>"

Aliases are usually placed in a file that will be sourced by Bash during initialization, such as the ~/.bashrc, ~/.profile, or ~/.bash_aliases. Here is the full contents of my ~/.terraform_aliases.bash file, which is source from ~/.bashrc during Bash initialization:
::

    alias tf='terraform'
    alias tfaa='terraform apply -auto-approve'
    alias tfda='terraform destroy -auto-approve'
    alias tfi='terraform init'
    alias tfp='terraform plan'

This command in my ~/.bashrc sources the ~/.terraform_aliases.bash file, ensuring that these aliases are present every time I open a terminal.
::

    source ~/.terraform_aliases.bash

**NOTE**: The aliases could just as easily be located directly in the ~/.bashrc rather than being sourced. I source the file rather than having them in ~/.bashrc because I have (literally) hundreds of aliases, and breaking them into separate files helps keep them organized.

To use an alias you just type the alias name as if it were a command. To use the 'tfaa' alias I would enter the following on the command line:
::

    tfaa

...which would be the same as typing:
::

    terraform apply --auto-approve


Terraform State
===============
Terraform keeps track of the state of configured resources using a file called `terraform.state <https://developer.hashicorp.com/terraform/language/state>`_, which is a JSON-formatted text file containing all of the attributes of every resource deployed by a Terraform Run. The 'terraform.state' file *can* be examined by using a tool like `jq <https://stedolan.github.io/jq/>`_; however, Terraform provides a set of commands for viewing the resources in the terraform.state file to view the current state of the Run.

You can list the resources in the terraform.state file with:
::

    terraform state list

Here is the output of 'terraform state list' for what is deployed by deploying `Example 4`_.
::

    $ tf state list
    module.rg[0].azurerm_resource_group.rg
    module.rg[1].azurerm_resource_group.rg
    module.rg[2].azurerm_resource_group.rg

You can also view details of each object by using 'terraform state show *object_name*, as shown here:
::

    $ tf state show module.rg`0 .azurerm_resource_group.rg
    # module.rg`0 .azurerm_resource_group.rg:
    resource "azurerm_resource_group" "rg" {
        id       = "/subscriptions/0f92c295-b01d-47ab-a709-1868040254df/resourceGroups/my_lab-1-rg"
        location = "westus2"
        name     = "my_lab-1-rg"
    }

Examining the state of an object in Terraform is particularly useful when you need to use an attribute of an object that isn't well defined in the resource documentation. This doesn't come up often, but when it does being able to examine the object to see what attributes you can access is extremely helpful. Any resource attribute you can see in the terraform.state file is usable within Terraform code.

Azure Terraform State Trick
---------------------------
My favorite aspect of the 'terraform.state' file is that it is the **sole** source of truth for Terraform. This means that if you want to completely reset Terraform's "view" of the current run all you need to do is delete or rename this file. Why is this great? Well, sometimes destroying a complex environment deployed by Terraform can take a really long time. I've been stuck waiting for an Azure lab to be destroyed for 15+ minutes in the past. (This is actually an Azure responsiveness issue rather than an Terraform issue, but knowing that doesn't make the time go by any faster.)

If you organize your lab naming scheme around a single *prefix* value that is incorporated into the name of all objects created by that run, what you can do to save time is just go to the Azure Portal and delete the resource-group(s) created by your Terraform Run. Then delete the 'terraform.state' file itself. Finally, change the *prefix* you are using with all of your object names. At this point all of the following will be true:

#. Azure will be deleting the Resource-Group and all of the objects it contains. It won't matter if this takes two minutes or an hour because...
#. Terraform will believe nothing is deployed because there is no state file. You can immediately begin testing your most recent changes to the Terraform configuration because...
#. With the new prefix none of the object names Terraform attempts to deploy will collide with existing objects.

  * Technically the concern regarding name collisions only applies to the resource-group name itself; however, there are a couple other objects that also require globally (or at least, organizationally) unique names, such as Log Analytics Workbooks and Storage Accounts.

Using this trick will spare you a lot of time if you start to create Terraform Runs with many levels of dependencies.

**NOTE**: This trick is only really only useful when you are working in an environment that allows a simple, hands-off group deletion option, like deleting an Azure Resource-Group or Kubernetes namesspace. GCP, and especially AWS, have no simple administrative container that can be deleted at-will to destroy all of the grouped objects.

**WARNING**: The corallary to the note above is that you should avoid deleting your terraform state file in all other cases; especially when working with AWS or GCP. I once had a corrupted deployment to AWS that caused the 'terraform destroy' command to fail due to an AWS error, so I had to track down every oject I had deployed with Terraform and delete them all manually. This was an incredible PITA. Deleting your terraform.state file without first running the 'terraform destroy' command will result in the same thing: to clean up your deployed resources you'll end up having to track all of them down to manually delete them. You have been warned.

Selective apply / destroy
=========================
You can restrict Terraform to deploying or destroying specific objects by using the '--target=<resource_name>' command-line argument. This can be particularly useful if you have a large Run and are trying to debug or test one of the final resources being deployed. (i.e. trying to debug the cloud-init being used with BIG-IP). In those cases all of the time necessary to destroy, then re-deploy, all of the resources that the BIG-IP depends on is effectively wasted time - all you *need* to destroy and re-deploy is the BIG-IP itself. This is not an uncommon scenario, and the answer is the '--target=<name>' argument.

To use --target=name you enter the terraform destroy or plan command like you normally would, but you add the '--target=' argument afterwards. For example, let's say my BIG-IP is deployed in a module called 'bigip'. I can destroy all of the objects related to that object alone by using the following command:
::

    terraform destroy --auto-approve --target=module.bigip

That command will destroy the resources created in my 'bigip' module and nothing else. 

**NOTE**: If the resource you are trying to destroy in this way is a dependency of a later resource, the command will fail. 

To re-deploy I have two options:
#. Use the '--target=' argument again when running the 'terraform apply' command
#. Run 'terraform apply [--auto-approve]' without the '--target=' argument and jsut let Terraform deploy everything that isn't already deployed (as per the terraform.state file).

**NOTE**: According to Terraform the '--target=<name>' argument should only be used for debugging/testing.

Terraform State file manipulation
=================================
It is possible to manually remove objects from the state file without destroying them. This only comes up rarely, but if you find yourself in a position where it is important you can do this with the **terraform state rm <resource_name>** command

Using Terraform with Git
========================
It is extremely common to use Git to provide source control for Terraform configurations. Entire DevOps ecosystems have been created around this relationship, and I would be remiss to not include a section on some best-practices related to the **.gitignore** file.

As you almost certainly know, the ``.gitignore`` file is used to exclude files from being included by git, and there are some files you really don't want included in your git repository. I've provided a list of these files below and urge you to use the ``.gitignore`` file to exclude them.

* .terraform/
   * Directory containing the dowloaded Providers and files pertaining to the modules defined in your Terraform configuration.
   * Add the following to .gitignore: ``.terraform*``
* .terraform.lock.hcl
   * File containing a list of the downloaded Providers and the hashes associated with each
   * Add the following to .gitignore: *.terraform\**
      * *.terraform\** excludes both the *.terraform.lock.hcl* file and the *.terraform/* directory
* .terraform.tfstate & .terraform.tfstate.backup
   * File containing the current state of any resources deployed by Terraform (see above)
   * Add the following to .gitignore: ``terraform.tfstate*``
      * Excludes both the *terraform.tfstate* and the *terraform.tfstate.backup* files.

More complex Terraform configurations might include an output directory for post-procesing template files, as well as a directory within which those template files might be stored. I names those directories *work_tmp* and *templates*, respectively. The *templates* directory should be included in a Git repository; however, the directory containing the post-processing versions of those templates should not, so I add that directory to my .gitignore.

The complete list of .gitignore additions would be:
::

    .terraform*
    .terraform.tfstate*
    work_tmp/



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

.. _NEXT: example_1.html
.. _BACK: Execution.html
.. _HOME: Index.html

`NEXT`_

`BACK`_

`HOME`_
