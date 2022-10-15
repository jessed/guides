# Motivation
The most frustrating aspect of Terraform is the "Day One" learning curve. When first starting out most of the examples I found (by which I mean: every single one), seemed to assume that you understand the basic operation of Terraform and focused on the more complex use-cases. The problem with that is that I held certain misconceptions that none of those guides actually addressed. The most significant one was how I was supposed to download the package (provider) to interact with a specific service?". The answer is "You don't", but all of the guides I found seemed to assume that knowledge and didn't address the topic. In hindsight I understand why, but it's been over two years and I still remember the intense frustration of that first day working with Terraform (TF).

This guide is intended to answer those very basic beginner questions, as well as walk you through the creation of your first (extremely) simple Terraform Run so you can see how the various pieces for together. 

# Organization
This guide is broken into several small parts intended to let you skip the frustration of discovering them yourself. It definitely does not replace the [Terraform Documentation](https://www.terraform.io/intro), but as you'll discover if you click the link, this guide will reduce the time you need to "internalize" how to use Terraform.

# Terrform
As stated, this guide is a simple introduction to [Terraform](https://www.terraform.io/intro), and we will be going over several of the basic elements of a basic Terraform deployment. Those elements are:
1. tl;dr: Quick Start
2. [Providers](https://github.com/jessed/guides/blob/main/Terraform/Providers.md)
3. [Configurations](https://github.com/jessed/guides/blob/main/Terraform/Configurations.md)
4. [Resources](https://github.com/jessed/guides/blob/main/Terraform/Resources.md)
5. [Modules](https://github.com/jessed/guides/blob/main/Terraform/Modules.md)
6. [Runs](https://github.com/jessed/guides/blob/main/Terraform/Runs.md)
7. [Variables](https://github.com/jessed/guides/blob/main/Terraform/Variables.md)
8. [Initialization](https://github.com/jessed/guides/blob/main/Terraform/Initialization.md)
9. [Execution: Plan, Apply, Destroy](https://github.com/jessed/guides/blob/main/Terraform/Execution.md)
10. Examples

## tl;dr: Quick Start
1. Write your Terraform code
   * I describe this somewhat below; however, if you are actually starting with this know that I have experienced your pain and have no sympathy. Helping you avoid that pain is the whole purpose of this guide.
2. `terraform init`
   * Initialize your TF environment, which includes a basic syntax check.
   * NOTE: This will download the required providers and enumerate your modules.
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

## Examples
### [Example 1](https://github.com/jessed/guides/blob/main/Terraform/example_1.md):
### [Example 2]():
### [Example 3]():
### [Example 4]():