# Registry
Terraform Providers are retrieved from a Registry. The official Hashicorp Terraform registry is [registry.terraform.io](https://registry.terraform.io/), which is used to download Providers for which a more specific source location is not provided. All of the examples shown on the [Providers](https://github.com/jessed/guides/blob/main/Terraform/Providers.md) page will use this default registry when downloading the specified provider(s).
<br/>

## Documentation
In addition to making the providers available for download by Terraform, the registry is also where the official documentation for each provider is located. For example, the documentation for the Azure provider is located at [registry.terraform.io/providers/hashicorp/azurerm/latest/docs](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs). The link above is for the latest version of the Provider but the documentation for earlier versions can be viewed with the dropdown at the top of the page.

**NOTE**: When creating or modifying a Terraform plan the documentation in the Registry is best documentation resource without question. It is very rare tht I have to look elsewhere for help with getting a Resource to work.
<br/>

## Example Configurations
All, or nearly all, Resources supported by a Provider are documented on the Provider documentation page. Further, nearly all of the examples show you not just the usage of the specific resource but also include examples of any pre-requisite resources necessary to make use of the Resource. For instance, the example on the [azurerm_linux_virtual_machine](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine) page doesn't just show examples of that particular resource, the page includes examples for every resource necessary to use it. The result is that in addition to an example the page contains at least a minimal example of these resources:

* [azurerm_resource_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group)
* [azurerm_virtual_network](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network)
* [azurerm_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet)
* [azurerm_network_interface](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface)

All of which are pre-requisites to creating a azurerm_linux_virtual_machine resource.

All of the resource configuration options (input) and attributes are shown below the examples.

**NOTE**: When having a problem working with a Resource it is frequently helpful to take a look at pages that require that resource. The configuration of other Resources that require the one you are working with will include their own examples, and sometimes those examples enhance the examples provided in the primary Documentation page. This situation isn't common, but I have encountered it enough times that this is one of the first things I do when I have a Resource that repeatedly fails to deploy with some cryptic error message.

[BACK](https://github.com/jessed/guides/blob/main/Terraform/Providers.md)

[NEXT](https://github.com/jessed/guides/blob/main/Terraform/Configurations.md)

[HOME](https://github.com/jessed/guides/blob/main/Terraform/README.md)