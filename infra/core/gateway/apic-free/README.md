<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azapi"></a> [azapi](#requirement\_azapi) | ~>2.0.0 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | ~>3.5.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~>4.42.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azapi"></a> [azapi](#provider\_azapi) | ~>2.0.0 |
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | ~>3.5.0 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~>4.42.0 |

## Resources

| Name | Type |
|------|------|
| [azapi_resource.apicenter_service](https://registry.terraform.io/providers/Azure/azapi/latest/docs/resources/resource) | resource |
| [azuread_application_api_access.apic](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application_api_access) | resource |
| [azuread_application_api_access.msgraph](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application_api_access) | resource |
| [azuread_application_redirect_uris.public](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application_redirect_uris) | resource |
| [azuread_application_redirect_uris.spa](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application_redirect_uris) | resource |
| [azuread_application_registration.entra_app](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application_registration) | resource |
| [azurerm_role_assignment.apic_data_reader](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.kv_secret_user](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_azurerm_client_object_id"></a> [azurerm\_client\_object\_id](#input\_azurerm\_client\_object\_id) | The Object ID of the Azure client (user or service principal) | `string` | n/a | yes |
| <a name="input_kv_id"></a> [kv\_id](#input\_kv\_id) | The ID of the Key Vault to store secrets | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The supported Azure location where the resource deployed | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the API Center service | `string` | n/a | yes |
| <a name="input_rg_id"></a> [rg\_id](#input\_rg\_id) | The Resource ID of the resource group to deploy resources into | `string` | n/a | yes |
| <a name="input_rg_name"></a> [rg\_name](#input\_rg\_name) | The name of the resource group to deploy resources into | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A list of tags used for deployed services. | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_apic_service_id"></a> [apic\_service\_id](#output\_apic\_service\_id) | The ID of the API Center service |
| <a name="output_apic_service_name"></a> [apic\_service\_name](#output\_apic\_service\_name) | The name of the API Center service |
| <a name="output_entra_app_id"></a> [entra\_app\_id](#output\_entra\_app\_id) | The Application (client) ID of the Entra app associated with the API Center service |
<!-- END_TF_DOCS -->