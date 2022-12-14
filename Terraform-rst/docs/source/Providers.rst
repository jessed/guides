=========
Providers
=========

Overview
========
A `Terraform Provider <https://www.terraform.io/docs/glossary#terraform-provider>`_ is a plugin that Terraform calls in order to communicate with the service or resource being configured. For example, in order to configure Azure resources Terraform uses the `azurerm <https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs>`_ provider. Providers are *usually* written by the organization that provides the product being configured, though that is not always the case. For example, the `BIG-IP <https://registry.terraform.io/providers/F5Networks/bigip/1.15.2>`_ is provided by F5, but the Azure provider is provided directly by Hashicorp (the same company that created Terraform).

The provider(s) required for the Terraform Run are identified by Terraform when you run a ``terraform init``, and are *automatically* downloaded. There are a two parts to provider configuration. The first declares that the Provider is required, and the second is the actual Provider configuration.


--------------------
Provider Declaration
--------------------
Here is an example of the Provider declaration:
::

    terraform {
      required_providers {
        azurerm = { version = "3.14.0" }
      }
    }

The 'terraform' block is not limited on only one Provider; more can be defined depending on what your Terraform Run requires. Here are a few example Provider configurations:

`Azure <https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs>`_
--------------------------------------------------------------------------------

**NOTE**: Along with identifying and downloading the Provider, ``terraform init`` will also ``upgrade`` the provider if a newer one is available and the specific version isn't specified in the provider declaration. The example above defines the specific version of the provider to be used, so the release of newer versions will be ignored. That said, a common approach is to use a version statement similar to ``version **~>** "3.14.0"``, and that syntax will result in the Provider being automatically upgraded whenever a new version is available. If that newer version includes changes to the options/arguments in any of the resources you are using you may find yourself having to refactor portions of your Terraform configuration to adjust to the new options. The best practice would be to use '=' to restrict the Provider to the specific version you are writing your code for. You can then allow the Provider to be upgraded when it is convenient for you, rather than potentially having to update a bunch of code that is unrelated to whatever you are actually trying to work on. 

The *Provider* configuration blocks define changes to the default provider behavior. Even without any changes each provider must still have a configuration block. Here is a default configuration block for the Azure Provider:
::

    provider "azurerm" { }

Provider configuration blocks can be much more complicated. Here is a configuration block for the Azure subscriber that includes a few modifications to the default behavior:
::

    provider "azurerm" {
      features {
        virtual_machine {
          # Necessary for license revocation when using BIG-IQ LM.
          graceful_shutdown                       = true
          delete_os_disk_on_deletion              = true
        }
        template_deployment {
          #  Allow the RG to be removed even if resources are still present
          delete_nested_items_during_deletion     = true
        }
        resource_group {
          # Allow the RG to be removed even if resources are still present
          prevent_deletion_if_contains_resources  = false
        }
      }
    }


`AWS  <https://registry.terraform.io/providers/hashicorp/aws/3.27.0/docs>`_
---------------------------------------------------------------------------
The Terraform AWS Provider configuration block shown here pulls the credentials and profile from local values (variables), and defines the default region for operations.
::

    terraform {
      required_providers {
        aws = {
          source = "hashicorp/aws"
          version = "~> 3.0"
        }
      }
    }

    provider "aws" {
      shared_credentials_file   = local.creds_file
      profile                   = local.profile
      region                    = var.region
    }

Notice that even the terraform configuration block differs from the Azure example. In this case the source of the provider is defined in addition to what version of the provider should be used.


`GCP <https://registry.terraform.io/providers/hashicorp/google/latest/docs>`_
-----------------------------------------------------------------------------
And finally, the GCP Provider.
::

    terraform {
      required_providers {
        google = {
          version = "4.40.0"
        }
      }
    }

    provider "google" {
      project                   = var.project
      region                    = var.region
      zone                      = var.zone
    }

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

.. _NEXT: Registry.html
.. _BACK: Index.html
.. _HOME: Index.html

`NEXT`_

`BACK`_

`HOME`_
