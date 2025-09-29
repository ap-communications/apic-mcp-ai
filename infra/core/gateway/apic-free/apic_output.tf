output "apic_service_id" {
  description = "The ID of the API Center service"
  value       = azapi_resource.apicenter_service.id
}

output "apic_service_name" {
  description = "The name of the API Center service"
  value       = azapi_resource.apicenter_service.name
}

output "entra_app_id" {
  description = "The Application (client) ID of the Entra app associated with the API Center service"
  value       = azuread_application_registration.entra_app.client_id

}
