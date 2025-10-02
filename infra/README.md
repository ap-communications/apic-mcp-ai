<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.7, < 2.0.0 |
| <a name="requirement_azapi"></a> [azapi](#requirement\_azapi) | ~>2.0.0 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | ~>3.5.0 |
| <a name="requirement_azurecaf"></a> [azurecaf](#requirement\_azurecaf) | ~>1.2.24 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~>4.42.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | ~>3.2.0 |
| <a name="requirement_time"></a> [time](#requirement\_time) | ~>0.9.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azapi"></a> [azapi](#provider\_azapi) | 2.0.1 |
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | 3.5.0 |
| <a name="provider_azurecaf"></a> [azurecaf](#provider\_azurecaf) | 1.2.31 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 4.42.0 |
| <a name="provider_null"></a> [null](#provider\_null) | 3.2.4 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_apic"></a> [apic](#module\_apic) | ./core/gateway/apic-free | n/a |
| <a name="module_atlassian_mcp"></a> [atlassian\_mcp](#module\_atlassian\_mcp) | ./core/gateway/apic-api/mcp | n/a |
| <a name="module_github_mcp"></a> [github\_mcp](#module\_github\_mcp) | ./core/gateway/apic-api/mcp | n/a |
| <a name="module_keyvault"></a> [keyvault](#module\_keyvault) | ./core/security/keyvault | n/a |
| <a name="module_msdocs_mcp"></a> [msdocs\_mcp](#module\_msdocs\_mcp) | ./core/gateway/apic-api/mcp | n/a |

## Resources

| Name | Type |
|------|------|
| [azapi_resource.apicenter_api_api_key_api_deployment](https://registry.terraform.io/providers/Azure/azapi/latest/docs/resources/resource) | resource |
| [azapi_resource.apicenter_api_api_key_api_ver](https://registry.terraform.io/providers/Azure/azapi/latest/docs/resources/resource) | resource |
| [azapi_resource.apicenter_api_api_key_api_ver_defi](https://registry.terraform.io/providers/Azure/azapi/latest/docs/resources/resource) | resource |
| [azapi_resource.apicenter_api_key_api](https://registry.terraform.io/providers/Azure/azapi/latest/docs/resources/resource) | resource |
| [azapi_resource.apicenter_env_api_key](https://registry.terraform.io/providers/Azure/azapi/latest/docs/resources/resource) | resource |
| [azapi_resource.apicenter_env_apim](https://registry.terraform.io/providers/Azure/azapi/latest/docs/resources/resource) | resource |
| [azapi_resource.apicenter_env_default_mcp](https://registry.terraform.io/providers/Azure/azapi/latest/docs/resources/resource) | resource |
| [azurecaf_name.kv_name](https://registry.terraform.io/providers/aztfmod/azurecaf/latest/docs/resources/name) | resource |
| [azurecaf_name.rg_name](https://registry.terraform.io/providers/aztfmod/azurecaf/latest/docs/resources/name) | resource |
| [azurerm_federated_identity_credential.github_actions_main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/federated_identity_credential) | resource |
| [azurerm_federated_identity_credential.github_actions_pr](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/federated_identity_credential) | resource |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_role_assignment.apic_github_actions](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_user_assigned_identity.github_actions](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity) | resource |
| [null_resource.api_definition_api_key_dummy](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [azuread_client_config.current](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/client_config) | data source |
| [azurerm_api_management.apim](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/api_management) | data source |
| [azurerm_api_management_subscription.sa_api_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/api_management_subscription) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_apim_name"></a> [apim\_name](#input\_apim\_name) | The name of the API Management instance | `string` | n/a | yes |
| <a name="input_apim_rg_name"></a> [apim\_rg\_name](#input\_apim\_rg\_name) | The name of the resource group containing the APIM instance | `string` | n/a | yes |
| <a name="input_environment_name"></a> [environment\_name](#input\_environment\_name) | The name of the azd environment to be deployed | `string` | n/a | yes |
| <a name="input_github_owner"></a> [github\_owner](#input\_github\_owner) | The GitHub repository owner to be used for the deployment | `string` | n/a | yes |
| <a name="input_github_repo"></a> [github\_repo](#input\_github\_repo) | The GitHub repository to be used for the deployment | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The supported Azure location where the resource deployed | `string` | n/a | yes |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | The subscription ID to deploy the resources | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_AZURE_LOCATION"></a> [AZURE\_LOCATION](#output\_AZURE\_LOCATION) | n/a |
| <a name="output_AZURE_TENANT_ID"></a> [AZURE\_TENANT\_ID](#output\_AZURE\_TENANT\_ID) | n/a |
| <a name="output_apic_entra_app_id"></a> [apic\_entra\_app\_id](#output\_apic\_entra\_app\_id) | The Application (client) ID of the Entra app associated with the API Center service |
| <a name="output_apic_name"></a> [apic\_name](#output\_apic\_name) | The name of the API Center instance |
| <a name="output_keyvault_name"></a> [keyvault\_name](#output\_keyvault\_name) | The name of the Key Vault instance |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | The name of the Resource Group |
<!-- END_TF_DOCS -->