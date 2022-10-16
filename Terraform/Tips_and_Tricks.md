# Tips and Tricks
Terraform has a few execution quirks that can become bothersome with frequent usage. One example is that both 'terraform apply' and 'terraform destroy' require an interactive approval. Bypassing this is possible with the use of the '--auto-apply' argument, but that's a lot to be typing everytime you want to perform or clean-up a terraform run. (And, being exceptionally lazy, I don't want to be typing that much every time I run a terraform command.) So what follows are the Bash aliases I use with terraform, as well as a few other things I do to a) simplify terraform usage and b) diagnose problems with terraform runs.
<br/>

## Bash aliases
Bash aliases are a way to create Bash commands that call actual programs. Bash aliases are defined as so:
```
alias alias_name="command_to_run [arguments]"
```

Aliases are usually placed in a file that will be sourced by Bash during initialization, such as the ~/.bashrc, ~/.profile, or ~/.bash_aliases. Here is the full contents of my ~/.terraform_aliases.bash file, which is source from ~/.bashrc during Bash initialization:
```
alias tf='terraform'
alias tfaa='terraform apply -auto-approve'
alias tfda='terraform destroy -auto-approve'
alias tfi='terraform init'
alias tfp='terraform plan'
```
<br/>
This command in my ~/.bashrc sources the ~/.terraform_aliases.bash file, ensuring that these aliases are present every time I open a terminal.
```
source ~/.terraform_aliases.bash
```

***Note***: The aliases could just as easily be located directly in the ~/.bashrc rather than being sourced. I source the file rather than having them in ~/.bashrc because I have (literally) hundreds of aliases, and breaking them into separate files helps keep them organized.

To use an alias you just type the alias name as if it were a command. To use the 'tfaa' alias I would enter the following on the command line:
```
tfaa
```

...which would be the same as typing:
```
terraform apply --auto-approve
```
<br/>

## Terraform State
Terraform keeps track of the state of configured resources using a file called [terraform.state](https://developer.hashicorp.com/terraform/language/state), which is a JSON-formatted text file containing all of the attributes of every resource deployed by a Terraform Run. The 'terraform.state' file *can* be examined by using a tool like [jq](https://stedolan.github.io/jq/); however, Terraform provides a set of commands for viewing the resources in the terraform.state file to view the current state of the Run.

You can list the resources in the terraform.state file with:
```
terraform state list
```

Here is the output of 'terraform state list' for what is deployed by deploying [Example 4](https://github.com/jessed/guides/blob/main/Terraform/example_4.md).
```
$ tf state list
module.rg[0].azurerm_resource_group.rg
module.rg[1].azurerm_resource_group.rg
module.rg[2].azurerm_resource_group.rg
```

You can also view details of each object by using 'terraform state show *[object_name]*', as shown here:
```
$ tf state show module.rg[0].azurerm_resource_group.rg
# module.rg[0].azurerm_resource_group.rg:
resource "azurerm_resource_group" "rg" {
    id       = "/subscriptions/0f92c295-b01d-47ab-a709-1868040254df/resourceGroups/my_lab-1-rg"
    location = "westus2"
    name     = "my_lab-1-rg"
}
```
<br/>

Examining the state of an object in Terraform is particularly useful when you need to use an attribute of an object that isn't well defined in the resource documentation. This doesn't come up often, but when it does being able to examine the object to see what attributes you can access is extremely helpful. Any resource attribute you can see in the terraform.state file is usable within Terraform code.


