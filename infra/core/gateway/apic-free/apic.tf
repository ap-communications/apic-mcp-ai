terraform {
  required_providers {
    azurerm = {
      version = "~>4.42.0"
      source  = "hashicorp/azurerm"
    }
    azapi = {
      source  = "Azure/azapi"
      version = "~>2.0.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~>3.5.0"
    }
  }
}

resource "azuread_application_registration" "entra_app" {
  display_name = var.name
}


resource "azuread_application_redirect_uris" "public" {
  application_id = azuread_application_registration.entra_app.id
  type           = "PublicClient"

  redirect_uris = [
    "ms-appx-web://Microsoft.AAD.BrokerPlugin/${azuread_application_registration.entra_app.client_id}",
    "https://vscode.dev/redirect",
    "http://localhost"
  ]
}

resource "azuread_application_redirect_uris" "spa" {
  application_id = azuread_application_registration.entra_app.id
  type           = "SPA"

  redirect_uris = [
    "https://${var.name}.portal.${var.location}.azure-apicenter.ms",

  ]
}

resource "azuread_application_api_access" "msgraph" {
  application_id = azuread_application_registration.entra_app.id
  api_client_id  = "00000003-0000-0000-c000-000000000000"

  scope_ids = [
    "e1fe6dd8-ba31-4d61-89e7-88639da4683d",
  ]
}

resource "azuread_application_api_access" "apic" {
  application_id = azuread_application_registration.entra_app.id
  api_client_id  = "c3ca1a77-7a87-4dba-b8f8-eea115ae4573"

  scope_ids = [
    "44327351-3395-414e-882e-7aa4a9c3b25d",
  ]
}


# API Center Service
resource "azapi_resource" "apicenter_service" {
  type                      = "Microsoft.ApiCenter/services@2024-06-01-preview"
  name                      = var.name
  location                  = var.location
  parent_id                 = var.rg_id
  schema_validation_enabled = false

  body = {
    sku = {
      name = "Free"
    }
    identity = {
      type = "SystemAssigned"
    }
    properties = {}
  }

  tags = var.tags

  response_export_values = [
    "identity.principalId",
  ]
}

resource "azurerm_role_assignment" "apic_data_reader" {
  scope                = azapi_resource.apicenter_service.id
  role_definition_name = "Azure API Center Data Reader"
  principal_id         = var.azurerm_client_object_id
}

resource "azurerm_role_assignment" "kv_secret_user" {
  scope                = var.kv_id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azapi_resource.apicenter_service.output.identity.principalId
}
