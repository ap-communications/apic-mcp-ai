<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~>4.42.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~>4.42.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_key_vault.kv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault) | resource |
| [azurerm_key_vault_secret.secrets](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_role_assignment.kv_admin](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_location"></a> [location](#input\_location) | The supported Azure location where the resource deployed | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the keyvault to be created | `string` | n/a | yes |
| <a name="input_principal_id"></a> [principal\_id](#input\_principal\_id) | The Id of the service principal to add to deployed keyvault access policies | `string` | n/a | yes |
| <a name="input_rg_name"></a> [rg\_name](#input\_rg\_name) | The name of the resource group to deploy resources into | `string` | n/a | yes |
| <a name="input_secrets"></a> [secrets](#input\_secrets) | A list of secrets to be added to the keyvault | <pre>list(object({<br/>    name  = string<br/>    value = string<br/>  }))</pre> | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A list of tags used for deployed services. | `map(string)` | n/a | yes |
| <a name="input_tenant_id"></a> [tenant\_id](#input\_tenant\_id) | The Tenant ID of the Azure Active Directory | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_AZURE_KEY_VAULT_ENDPOINT"></a> [AZURE\_KEY\_VAULT\_ENDPOINT](#output\_AZURE\_KEY\_VAULT\_ENDPOINT) | n/a |
| <a name="output_AZURE_KEY_VAULT_ID"></a> [AZURE\_KEY\_VAULT\_ID](#output\_AZURE\_KEY\_VAULT\_ID) | n/a |
<!-- END_TF_DOCS -->