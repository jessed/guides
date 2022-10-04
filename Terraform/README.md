# Motivation
The most frustrating aspect of Terraform is the "Day One" learning curve. When first starting out most of the examples I found (by which I mean: every single one), seemed to assume that you understand the basic operation of Terraform and focused on the more complex use-cases. The problem with that is that I held certain misconceptions that none of those guides actually addressed. The most significant one was how I was supposed to download the package (provider) to interact with a specific service?". The answer is "You don't", but all of the guides I found seemed to assume that knowledge and didn't address the topic. In hindsight I understand why, but it's been over two years and I still remember the intense frustration of that first day working with Terraform (TF).

This guide is intended to answer those very basic beginner questions, as well as walk you through the creation of your first (extremely) simple Terraform Run so you can see how the various pieces for together. 

# Organization
This guide is broken into several small parts intended to let you skip the frustration of discovering them yourself. It definitely does not replace the [Terraform Documentation](https://www.terraform.io/intro), but as you'll discover if you click the link, this guide will reduce the time you need to "internalize" how Terraform works.

# Terrform
As stated, this guide is a simple introduction to [Terraform](https://www.terraform.io/intro), and we will be going over several of the basic elements of a basic Terraform deployment. Those elements are:
1. tl;dr: Quick Start
2. Providers
3. Configurations
4. Resources
5. Modules
6. Runs
7. Variables
8. Initialization
9. Execution: Plan, Apply, Destroy
10. Summary

## tl;dr: Quick Start
1. Write your Terraform code
   * I describe this somewhat below; however, if you are actually starting with this know that I have experienced your pain and have no sympathy. Helping you avoid that pain is the whole purpose of this guide.
2. `terraform init`
   * This will download the required providers and enumerate your modules.
   * Initialize your TF environment, which includes a basic syntax check.
3. `terraform plan`
   * More thorough syntax check
   * Determine order of operations based on dependencies
   * Logic check - checks for unmet dependencies, circular logic, missing variables, etc...
4. `terraform apply`
   * Deploy the configuration.
   * Communication/authentication/authorization issues will be caught at this stage.
   * Failures will *not* be rolled back automatically.
5. `terraform destroy`
   * Destroy/delete deployed objects
   * Reverses the order of operations determined at the time of deployement

## Providers
A [Terraform Provider](https://www.terraform.io/docs/glossary#terraform-provider) is a plugin that Terraform calls to communicate with the service being configured. For example, in order to configure Azure resources Terraform uses the [azurerm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs) provider. Providers are *usually* written by the organization that provides the product being configured, though that is not always the case. For example, the (BIG-IP)[https://registry.terraform.io/providers/F5Networks/bigip/1.15.2] is provided by F5, but the Azure provider is provided directly by Hashicorp (the same company that created Terraform).

## Configurations
A Terraform [Configuration](https://www.terraform.io/docs/glossary#terraform-configuration) is a block of code that *declaratively* describes how your infrastructure should be configured. In it's very simplest form a Terraform run can consist of only a single Configuration. Here is a very simple example Configuration:

    resource "null_resource" "test" {
      provisioner "local-exec" {
        command = "echo ${split("/", var.ecr_url)[0]}"
      }
    }

In this examle the Configuration consists of a Resource, but it just as easily could have been a call to a module:

    module "rg" {
      source                      = "./modules/resource_group"
      rg                          = local.rg
    }

Or an 'output' block:

    output "my_out" {
      value  = "This is the output - user: ${local.data.admin_user}"
    }

## Resources
A Terraform [Resource](https://www.terraform.io/docs/glossary#resource) is a block that describes an infrastructure object. For example, you may have a "resource" that describes a virtual-machine in Azure. The resource would describe everything about that VM, like the number of CPU cores, amount of memory, disk size, and number of interfaces. Terraform will send that resource definition to the appropriate [Provider](https://www.terraform.io/docs/glossary#terraform-provider) so that the described object can be created.

Resources are easily the most common element of Terraform configuration, and all of the resources supported by a particular provider are described in the provider documentation. For example, here is the documentation for the [azurerm_linux_virtual_machine](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine) resource.

Note: If you review that documentation you'll notice that the example near the top starts with the creation of the a virtual-network, then a subnet, then an interface, and *finally* an example of the resource we are actually talking about. This is a fairly common theme in Terraform documentation. It is very common for Terraform examples to include every other resource required by the object in question.

## Modules
A Terraform [Module](https://www.terraform.io/docs/glossary#module) is a collection of Terraform [Configurations](https://www.terraform.io/docs/glossary#terraform-configuration) that manage a particular type of infrastructure resource. For example, you may write a module to configure an Azure Resource-Group, or a module to provide configure the virtual-network and subnets that a BIG-IP is deployed to.

Modules are to Terraform what library files are to programming languages. They allow you to configure one or more elements, and then can be re-used multiple times in the same Terraform Run to configure those elements multiple times.

For example, you may have a module called "virtual_network" that configures an Azure Virtual Network, then call that same module to create a client network, server network, and BIG-IP network. The code to create a virtual-network is only written once, as a module, but then executed multiple times with different input variables.

## Run
A Terraform [Run](https://www.terraform.io/docs/glossary#run) consists of one or more [Resources](https://www.terraform.io/docs/glossary#resource). Resources are what will actually happen when you enter `terraform apply` to deploy your configuration.

Terraform [Resources](https://www.terraform.io/docs/glossary#resource) are blocks of Infrastructure-as-Code (IaC) elements. These define what the deployment *should* be and leave it up to the Terraform logic and the provider to make happen. While several aspects of Terraform seem quite similar to a programming language, what you are actually "coding" is how things should be. When you run `terraform apply`, you are telling Terraform to make them that way.

## Variables
[Variables](https://www.terraform.io/language/values/variables) are just that. They are provided to the various [Configurations](https://www.terraform.io/docs/glossary#terraform-configuration) in lieu of static values to allow for simpler description of what should be deployed. That said, Variables in Terraform are a source of frequent confusion and much gnashing of teeth.

There are two basic types of varibales: [Input Variables](https://www.terraform.io/language/values/variables) and [Local Values](https://www.terraform.io/language/values/locals).

### Input Variables
[Input variables](https://www.terraform.io/language/values/variables) are provided via configuration files, on the CLI, or pulled from environment variables. These are immutable (i.e. cannot be changed once defined), and they are defined when Terraform is executed. Dynamic values cannot be used, nor can one input variable receive its value from another input variable. These are static, immutable, and defined at run-time.

### Local Values
[Local values](https://www.terraform.io/language/values/locals) are also immutable, however these can receive dynamically generated values rather than static values. Unlike Input variables, local values can use other variables as part of the value.

### Variable Usage
Here is a simple example illustrating the defintion of both:

    variable "prefix" { default = "my_prefix" }
    locals { vnet_name = "${var.prefix}-vnet" }

The variable "prefix" would contain the value *my_prefix*, and the local value "vnet_name" would contain the value *my_prefix-vnet*. However, you would *not* be able to define input variable that leverage the existing value of the *prefix* variable.

> Tip: All Input variable names are referenced using the 'var.' prefix, and all local values are referenced using the 'local.' prefix.

### Defining Variables
The number of variables in a moderately complex Terraform Configuration can be quite large. For this reason there are several methods of breaking up your variables into different files. The benefit of this approach is that you can isolate the variables that apply to one group of objects in their own file, making it easier to find them if/when you decide to change something.

By default Terraform will source certain files for variable definitions:
* vars.tf
* variables.tf
* terraform.tfvars
* terraform.tfvars.json
  
Additional files can be specified on the CLI using the *-var-file* option as shown here:

`terraform apply -var-file="my_variables.tfvars"`

That syntax applies to files with the following extensions:
* .tfvars
* .tfvars.json

To simplify the import of additional variable files you can insert ".auto" between the filename and the ".tfvars" or ".tfvars.json" extension. Naming them this way removes the need to specify the filenames using the '-var-file' CLI option. 

#### Important Take-away
The names of variables defined in *.tfvars or *.auto.tfvars files must be pre-defined in one of the automatic variable files. For example, if I have a variable called "bigip" in a file called "v_bigip.auto.tfvars", an empty "placeholder" variable defining that name must be located in one of the files that is imported automatically. Here is an example of how I would import a variable file called "v_bigip.auto.tfvars" containing a variable called "bigip":

**vars.tf**

    variable "bigip"   {}

**v_bigip.auto.tfvars**

    bigip = {
      name   = "my_ltm_01"
    }

Terraform would recognize a variable called "bigip" containing a nested variable called "use_paygo" with a string value of "my_ltm_01". If the placeholder variable is not present the variable(s) within the v_bigip.auto.tfvars file would not be included. You would also get a runtime error when Terraform attempts to import the variables define in the "v_bigip.auto.tfvars" file.


## Initialization: `terraform init`
When you run `terraform init` Terraform will read all of the configuration files in your current directory and download all of the required *providers* for you. These will be placed in a directory called `.terraform/providers/...`. It will also identify every [module](https://www.terraform.io/docs/glossary#module) used in your configuration and write the list to `.terraform/modules/modules.json`.

When you run `terraform init` Terraform reads every file that ends with `.tf` in the current directory and looks for a block called  `terraform`, which contains a sub-block called `required_providers`. The `required_providers` block contains a list of every 3rd party "provider" required by your terraform configuration. It does not need to include default terraform providers - only 3rd party providers that provide additional functionality.

### Important Take-away
The first thing to understand here is that, other than the Terraform package itself, **nothing is manually downloaded**. Terraform will automatically download the components it requires when it is *initialized*. (I spent a humiliating amount of time figuring this out.) The second thing to understand is that Terraform initialization *is not the first step* in creating a new plan/deployment. Counter-intuitively, terraform initialization takes place after you've written all of the code and right before you actually try to run the plan to do something. 

Note: Running `terraform init` does not verify that your code is without flaws or actually does anything at all. It *does* perform a basic syntax check, but that's it.


## Execution: Plan, Apply, Destroy
[terraform plan](https://www.terraform.io/cli/commands/plan) is used to perform an exhaustive check of your code, very similar to a 'dry-run' option. It will check the syntax, variable assignments, and attempt to identify circular references. (Circular references are when one resource depends on another, but that other object depends on the first one. Sometimes the dependency chain can include three or four objects, making identification of the circular reference difficult.)

Performing a `terraform plan` is always recommended prior to actually applying the configuration, and will most likely become an internalized part of your deployment process.

[terraform apply](https://www.terraform.io/cli/commands/apply) is used to actually apply your configuration. It goes through the same process as [terraform plan](https://www.terraform.io/cli/commands/plan), but this time the changes are actually implemented. As the 'apply' is executed Terraform will be writing completed actions to the 'terraform.state' file. The 'terraform.state' file contains [state](https://www.terraform.io/language/state) information about the current, successfully-deployed configuration. Only resources that are *successfully* deployed are written to the state file. This file is then used for if Terraform is called again to compare the current deployment with a changed configuration to determine what it actually has to do.

For example, if you deployed a BIG-IP and a server in a previous 'terraform apply', then change something about the server configuration, Terraform will use the 'terraform.state' file to determine what it actually needs to do to make the deployed configuration match your IaC configuration. If the change to the servers configuration in Terraform doesn't impact the BIG-IP, then the server would be redeployed with the new configuration while the BIG-IP wouldn't be modified. 

[terraform destroy](https://www.terraform.io/cli/commands/destroy) is used to destroy/delete resources that have been deployed. The 'destroy' command will use the terraform.state file to remove objects in the opposite order of their deployment. The intent is to remove resources that have dependencies on other objects before attempting to remove those other objects. This process does work quite well, thoough it is not uncommon for an object in a public cloud to be 'marked for deletion' without having actually been deleted when Terraform attempts to delete the object it is dependent on. In these cases the 'destroy' operation will fail and you will need to run 'terraform destroy' again.

The scenario above occurs frequently enough that when dealing with certain public clouds I start out by running 'terraform destroy --auto-approve' three times, separated by semicolons so that the second and third calls will be occur immediately. Calling 'terraform destroy' when nothing is deployed doesn't cause problems because the 'destroy' command updates the 'terraform.state' file as each resource is destroyed, so subsequent calls only act on resources that are still deployed.

