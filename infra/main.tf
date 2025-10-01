locals {
  tags           = { azd-env-name : var.environment_name }
  sha            = base64encode(sha256("${var.environment_name}${var.location}${data.azurerm_client_config.current.subscription_id}"))
  resource_token = substr(replace(lower(local.sha), "[^A-Za-z0-9_]", ""), 0, 13)
}

resource "azurecaf_name" "rg_name" {
  name          = var.environment_name
  resource_type = "azurerm_resource_group"
  random_length = 0
  clean_input   = true
}

resource "azurecaf_name" "kv_name" {
  name          = var.environment_name
  resource_type = "azurerm_key_vault"
  random_length = 0
  clean_input   = true
}

data "azurerm_api_management" "apim" {
  name                = var.apim_name
  resource_group_name = var.apim_rg_name
}

data "azurerm_api_management_subscription" "sa_api_key" {
  api_management_id = data.azurerm_api_management.apim.id
  subscription_id   = "testsaaiapi"
}

# Deploy resource group
resource "azurerm_resource_group" "rg" {
  name     = azurecaf_name.rg_name.result
  location = var.location
  // Tag the resource group with the azd environment name
  // This should also be applied to all resources created in this module
  tags = { azd-env-name : var.environment_name }
}


module "keyvault" {
  source = "./core/security/keyvault"

  name         = lower("${azurecaf_name.kv_name.result}-${substr(local.resource_token, 0, 3)}")
  location     = var.location
  rg_name      = azurerm_resource_group.rg.name
  tenant_id    = data.azurerm_client_config.current.tenant_id
  principal_id = data.azurerm_client_config.current.object_id
  tags         = local.tags
  secrets = [
    {
      name  = "sa-api-key"
      value = "${data.azurerm_api_management_subscription.sa_api_key.primary_key}"
    }
  ]

}
module "apic" {
  source = "./core/gateway/apic-free"

  name                     = "apic-${var.environment_name}-${substr(local.resource_token, 0, 3)}"
  location                 = var.location
  rg_name                  = azurerm_resource_group.rg.name
  rg_id                    = azurerm_resource_group.rg.id
  tags                     = local.tags
  azurerm_client_object_id = data.azurerm_client_config.current.object_id
  kv_id                    = module.keyvault.AZURE_KEY_VAULT_ID
}


resource "azurerm_user_assigned_identity" "github_actions" {
  location            = var.location
  name                = "github-actions"
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_federated_identity_credential" "github_actions_main" {
  name                = "gitac-main"
  resource_group_name = azurerm_resource_group.rg.name
  audience            = ["api://AzureADTokenExchange"]
  issuer              = "https://token.actions.githubusercontent.com"
  parent_id           = azurerm_user_assigned_identity.github_actions.id
  subject             = "repo:${var.github_owner}/${var.github_repo}:ref:refs/heads/main"
}

resource "azurerm_federated_identity_credential" "github_actions_pr" {
  name                = "gitac-pr"
  resource_group_name = azurerm_resource_group.rg.name
  audience            = ["api://AzureADTokenExchange"]
  issuer              = "https://token.actions.githubusercontent.com"
  parent_id           = azurerm_user_assigned_identity.github_actions.id
  subject             = "repo:${var.github_owner}/${var.github_repo}:pull_request"
}

resource "azurerm_role_assignment" "apic_github_actions" {
  scope                = module.apic.apic_service_id
  role_definition_name = "Azure API Center Service Contributor"
  principal_id         = azurerm_user_assigned_identity.github_actions.principal_id
}


resource "azapi_resource" "apicenter_env_default_mcp" {
  type                      = "Microsoft.ApiCenter/services/workspaces/environments@2024-06-01-preview"
  name                      = "default-mcp-env"
  parent_id                 = "${module.apic.apic_service_id}/workspaces/default"
  schema_validation_enabled = false

  body = {
    properties = {
      title            = "Default MCP Environment"
      kind             = "development"
      description      = "Auto-generated environment"
      customProperties = {}
    }
  }
}

resource "azapi_resource" "apicenter_env_apim" {
  type                      = "Microsoft.ApiCenter/services/workspaces/environments@2024-06-01-preview"
  name                      = "apim"
  parent_id                 = "${module.apic.apic_service_id}/workspaces/default"
  schema_validation_enabled = false

  body = {
    properties = {
      title            = "APIM Environment"
      kind             = "production"
      description      = "Auto-generated environment"
      customProperties = {}
    }
  }
}

module "github_mcp" {
  source                 = "./core/gateway/apic-api/mcp"
  mcp_name               = "github"
  mcp_description        = "Access GitHub repositories, issues, and pull requests through secure API integration."
  apicenter_workspace_id = "${module.apic.apic_service_id}/workspaces/default"
  mcp_env_name           = azapi_resource.apicenter_env_default_mcp.name
  mcp_runtime_uri        = "https://api.githubcopilot.com/mcp"
  rg_name                = azurerm_resource_group.rg.name
  api_center_name        = module.apic.apic_service_name

}


module "atlassian_mcp" {
  source = "./core/gateway/apic-api/mcp"

  mcp_name               = "atlassian"
  mcp_description        = "Connect to Jira and Confluence for issue tracking and documentation."
  apicenter_workspace_id = "${module.apic.apic_service_id}/workspaces/default"
  mcp_env_name           = azapi_resource.apicenter_env_default_mcp.name
  mcp_runtime_uri        = "https://mcp.atlassian.com/v1/sse"
  rg_name                = azurerm_resource_group.rg.name
  api_center_name        = module.apic.apic_service_name

}

module "msdocs_mcp" {
  source = "./core/gateway/apic-api/mcp"

  mcp_name               = "msdocs"
  mcp_description        = "AI assistant with real-time access to official Microsoft documentation."
  apicenter_workspace_id = "${module.apic.apic_service_id}/workspaces/default"
  mcp_env_name           = azapi_resource.apicenter_env_default_mcp.name
  mcp_runtime_uri        = "https://learn.microsoft.com/api/mcp"
  rg_name                = azurerm_resource_group.rg.name
  api_center_name        = module.apic.apic_service_name

}

resource "azapi_resource" "apicenter_api_key_api" {
  type                      = "Microsoft.ApiCenter/services/workspaces/apis@2024-06-01-preview"
  name                      = "api-key-publish"
  parent_id                 = "${module.apic.apic_service_id}/workspaces/default"
  schema_validation_enabled = false

  body = {
    properties = {
      title                 = "api-key-publish"
      summary               = "API Key Publish for APIM"
      description           = "API Key Publish for APIM"
      kind                  = "rest"
      externalDocumentation = []
      contacts              = []
      customProperties      = {}
    }
  }
}

resource "azapi_resource" "apicenter_env_api_key" {
  type                      = "Microsoft.ApiCenter/services/workspaces/environments@2024-06-01-preview"
  name                      = "api-key"
  parent_id                 = "${module.apic.apic_service_id}/workspaces/default"
  schema_validation_enabled = false

  body = {
    properties = {
      title            = "api-key"
      kind             = "production"
      server           = { managementPortalUri = [] }
      onboarding       = { developerPortalUri = [] }
      customProperties = {}
    }
  }
}

resource "azapi_resource" "apicenter_api_api_key_api_ver" {
  type                      = "Microsoft.ApiCenter/services/workspaces/apis/versions@2024-06-01-preview"
  name                      = "original"
  parent_id                 = azapi_resource.apicenter_api_key_api.id
  schema_validation_enabled = false

  body = {
    properties = {
      title          = "Original"
      lifecycleStage = "production"
    }
  }
}


resource "azapi_resource" "apicenter_api_api_key_api_ver_defi" {
  type                      = "Microsoft.ApiCenter/services/workspaces/apis/versions/definitions@2024-06-01-preview"
  name                      = "openapi"
  parent_id                 = azapi_resource.apicenter_api_api_key_api_ver.id
  schema_validation_enabled = false

  body = {
    properties = {
      title       = "openapi"
      description = "API Key Publish for APIM"
    }
  }
}


resource "azapi_resource" "apicenter_api_api_key_api_deployment" {
  type                      = "Microsoft.ApiCenter/services/workspaces/apis/deployments@2024-06-01-preview"
  name                      = "apim-api-key-publish"
  parent_id                 = azapi_resource.apicenter_api_key_api.id
  schema_validation_enabled = false

  body = {
    properties = {
      title            = "apim-api-key-publish"
      environmentId    = "/workspaces/default/environments/${azapi_resource.apicenter_env_apim.name}"
      definitionId     = "/workspaces/default/apis/${azapi_resource.apicenter_api_key_api.name}/versions/${azapi_resource.apicenter_api_api_key_api_ver.name}/definitions/${azapi_resource.apicenter_api_api_key_api_ver_defi.name}"
      server           = { runtimeUri = ["${data.azurerm_api_management.apim.gateway_url}"] }
      customProperties = {}
    }
  }
}

resource "null_resource" "api_definition_api_key_dummy" {
  triggers = {
    resource_group_name = azurerm_resource_group.rg.name
    api_center_name     = module.apic.apic_service_name
    api_id              = azapi_resource.apicenter_api_key_api.name
    version_id          = azapi_resource.apicenter_api_api_key_api_ver.name
    definition_id       = azapi_resource.apicenter_api_api_key_api_ver_defi.name
  }

  provisioner "local-exec" {
    command = <<-EOT
      az apic api definition import-specification \
      --resource-group  "${self.triggers.resource_group_name}" \
      --service-name "${self.triggers.api_center_name}" \
      --api-id "${self.triggers.api_id}" \
      --version-id "${self.triggers.version_id}" \
      --definition-id "${self.triggers.definition_id}" \
      --format "inline" \
      --value '{
        "openapi": "3.0.1",
        "info": {
          "title": "${self.triggers.api_id}",
          "description": "API Key Publish for APIM",
          "version": "1.0"
        },
        "servers": [
          {
        "url": ""
          }
        ],
        "paths": {
          "/test": {
        "post": {
          "summary": "test Endpoint",
          "description": "test endpoint. ${self.triggers.api_id}のダミーオペレーション。(API実行不可)",
          "operationId": "test-endpoint",
          "responses": {
            "200": {
          "description": ""
            }
          }
        }
          }
        },
        "components": {
          "securitySchemes": {
        "apiKeyHeader": {
          "type": "apiKey",
          "name": "Ocp-Apim-Subscription-Key",
          "in": "header"
        },
        "apiKeyQuery": {
          "type": "apiKey",
          "name": "subscription-key",
          "in": "query"
        }
          }
        },
        "security": [
          {
        "apiKeyHeader": []
          },
          {
        "apiKeyQuery": []
          }
        ]
      }
    ' \
      --specification '{"name":"openapi","version":"3.0.1"}'
    EOT
  }
}

