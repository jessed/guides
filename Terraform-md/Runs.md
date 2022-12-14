# Run
A Terraform [Run](https://www.terraform.io/docs/glossary#run) consists of one or more [Resources](https://www.terraform.io/docs/glossary#resource). Resources are what will actually happen when you enter `terraform apply` to deploy your configuration.

Terraform [Resources](https://www.terraform.io/docs/glossary#resource) are blocks of Infrastructure-as-Code (IaC) elements. These define what the deployment *should* be and leave it up to the Terraform logic and the provider to make happen. While several aspects of Terraform seem quite similar to a programming language, what you are actually "coding" is how things should be. When you run `terraform apply`, you are telling Terraform to make them that way.

[BACK](https://github.com/jessed/guides/blob/main/Terraform/Modules.md)

[NEXT](https://github.com/jessed/guides/blob/main/Terraform/Variables.md)

[HOME](https://github.com/jessed/guides/blob/main/Terraform/README.md)