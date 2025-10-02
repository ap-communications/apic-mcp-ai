# Declare output values for the main terraform module.
#
# This allows the main terraform module outputs to be referenced by other modules,
# or by the local machine as a way to reference created resources in Azure for local development.
# Secrets should not be added here.
#
# Outputs are automatically saved in the local azd environment .env file.
# To see these outputs, run `azd env get-values`. `azd env get-values --output json` for json output.

output "AZURE_LOCATION" {
  value = var.location
}

output "AZURE_TENANT_ID" {
  value = data.azurerm_client_config.current.tenant_id
}

output "apic_entra_app_id" {
  description = "The Application (client) ID of the Entra app associated with the API Center service"
  value       = module.apic.entra_app_id

}

output "apic_name" {
  description = "The name of the API Center instance"
  value       = module.apic.apic_service_name
}

output "keyvault_name" {
  description = "The name of the Key Vault instance"
  value       = lower("${azurecaf_name.kv_name.result}-${substr(local.resource_token, 0, 3)}")
}

output "resource_group_name" {
  description = "The name of the Resource Group"
  value       = azurerm_resource_group.rg.name

}
