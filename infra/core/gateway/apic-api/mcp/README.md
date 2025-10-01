<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azapi"></a> [azapi](#requirement\_azapi) | ~>2.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azapi"></a> [azapi](#provider\_azapi) | ~>2.0.0 |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |
| <a name="provider_time"></a> [time](#provider\_time) | n/a |

## Resources

| Name | Type |
|------|------|
| [azapi_resource.apicenter_api_mcp_server](https://registry.terraform.io/providers/Azure/azapi/latest/docs/resources/resource) | resource |
| [azapi_resource.apicenter_api_mcp_server_deployment](https://registry.terraform.io/providers/Azure/azapi/latest/docs/resources/resource) | resource |
| [azapi_resource.apicenter_api_mcp_server_original](https://registry.terraform.io/providers/Azure/azapi/latest/docs/resources/resource) | resource |
| [azapi_resource.apicenter_api_mcp_server_original_default_sse](https://registry.terraform.io/providers/Azure/azapi/latest/docs/resources/resource) | resource |
| [azapi_resource.apicenter_api_mcp_server_original_default_streamable](https://registry.terraform.io/providers/Azure/azapi/latest/docs/resources/resource) | resource |
| [null_resource.api_definition_import_sse](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.api_definition_import_streamable](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [time_sleep.wait_10_seconds](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_api_center_name"></a> [api\_center\_name](#input\_api\_center\_name) | The name of the API Center service | `string` | n/a | yes |
| <a name="input_apicenter_workspace_id"></a> [apicenter\_workspace\_id](#input\_apicenter\_workspace\_id) | The ID of the API Center workspace | `string` | n/a | yes |
| <a name="input_mcp_description"></a> [mcp\_description](#input\_mcp\_description) | The description of the MCP server | `string` | n/a | yes |
| <a name="input_mcp_env_name"></a> [mcp\_env\_name](#input\_mcp\_env\_name) | The environment name for MCP deployment | `string` | n/a | yes |
| <a name="input_mcp_name"></a> [mcp\_name](#input\_mcp\_name) | The name of the MCP server | `string` | n/a | yes |
| <a name="input_mcp_runtime_uri"></a> [mcp\_runtime\_uri](#input\_mcp\_runtime\_uri) | The runtime URI for the MCP server | `string` | n/a | yes |
| <a name="input_rg_name"></a> [rg\_name](#input\_rg\_name) | The name of the resource group | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_mcp_api_deployment_id"></a> [mcp\_api\_deployment\_id](#output\_mcp\_api\_deployment\_id) | The ID of the MCP API deployment |
| <a name="output_mcp_api_id"></a> [mcp\_api\_id](#output\_mcp\_api\_id) | The ID of the MCP API |
| <a name="output_mcp_api_name"></a> [mcp\_api\_name](#output\_mcp\_api\_name) | The name of the MCP API |
| <a name="output_mcp_api_version_id"></a> [mcp\_api\_version\_id](#output\_mcp\_api\_version\_id) | The ID of the MCP API version |
| <a name="output_mcp_sse_definition_id"></a> [mcp\_sse\_definition\_id](#output\_mcp\_sse\_definition\_id) | The ID of the MCP SSE definition |
| <a name="output_mcp_streamable_definition_id"></a> [mcp\_streamable\_definition\_id](#output\_mcp\_streamable\_definition\_id) | The ID of the MCP streamable definition |
<!-- END_TF_DOCS -->