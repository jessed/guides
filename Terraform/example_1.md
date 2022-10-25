# Example #1 - Simple variables and output
The following example shows the Terraform code to:
1. Define a variable called 'prefix'
2. Create a local value called 'rg_name' that incorporates the value of the 'prefix' variable
3. Create a [null-resource](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) to call the command-line 'echo' command to print the values of the variable and local value
4. Create Terraform Output blocks that show the values of the variable and the local value

```
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
```

***NOTE***: Terraform Runs that only involve built-in providers like ***null-resource*** do not require ***terraform*** or ***provider*** blocks. This makes it very easy to create trivial runs for the purpose of testing Terraform syntax and behavior. The example above was something I wrote when I first started using Terraform to test a call to a null-resource. 


[BACK](https://github.com/jessed/guides/blob/main/Terraform/Tips_and_Tricks.md)

[NEXT](https://github.com/jessed/guides/blob/main/Terraform/example_2.md)

[HOME](https://github.com/jessed/guides/blob/main/Terraform/README.md)