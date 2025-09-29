terraform {
  required_providers {
    azapi = {
      source  = "Azure/azapi"
      version = "~>2.0.0"
    }
  }
}

resource "azapi_resource" "apicenter_api_mcp_server" {
  type                      = "Microsoft.ApiCenter/services/workspaces/apis@2024-06-01-preview"
  name                      = "${var.mcp_name}-mcp-server"
  parent_id                 = var.apicenter_workspace_id
  schema_validation_enabled = false

  body = {
    properties = {
      title                 = "${var.mcp_name}"
      summary               = "${var.mcp_description}"
      description           = "${var.mcp_description}"
      kind                  = "mcp"
      externalDocumentation = []
      contacts              = []
      customProperties      = {}
    }
  }
}


resource "azapi_resource" "apicenter_api_mcp_server_original" {
  type                      = "Microsoft.ApiCenter/services/workspaces/apis/versions@2024-06-01-preview"
  name                      = "original"
  parent_id                 = azapi_resource.apicenter_api_mcp_server.id
  schema_validation_enabled = false

  body = {
    properties = {
      title          = "Original"
      lifecycleStage = "production"
    }
  }
}

resource "azapi_resource" "apicenter_api_mcp_server_original_default_sse" {
  type                      = "Microsoft.ApiCenter/services/workspaces/apis/versions/definitions@2024-06-01-preview"
  name                      = "default-sse"
  parent_id                 = azapi_resource.apicenter_api_mcp_server_original.id
  schema_validation_enabled = false

  body = {
    properties = {
      title       = "SSE Definition for ${var.mcp_name}"
      description = "Auto-generated definition for ${var.mcp_name}"
    }
  }
}

resource "azapi_resource" "apicenter_api_mcp_server_original_default_streamable" {
  type                      = "Microsoft.ApiCenter/services/workspaces/apis/versions/definitions@2024-06-01-preview"
  name                      = "default-streamable"
  parent_id                 = azapi_resource.apicenter_api_mcp_server_original.id
  schema_validation_enabled = false

  body = {
    properties = {
      title       = "Streamable Definition for ${var.mcp_name}"
      description = "Auto-generated definition for ${var.mcp_name}"
    }
  }
}

resource "azapi_resource" "apicenter_api_mcp_server_deployment" {
  type                      = "Microsoft.ApiCenter/services/workspaces/apis/deployments@2024-06-01-preview"
  name                      = "default-deployment"
  parent_id                 = azapi_resource.apicenter_api_mcp_server.id
  schema_validation_enabled = false

  body = {
    properties = {
      title            = "Deployment to ${var.mcp_env_name}"
      environmentId    = "/workspaces/default/environments/${var.mcp_env_name}"
      definitionId     = "/workspaces/default/apis/${azapi_resource.apicenter_api_mcp_server.name}/versions/${azapi_resource.apicenter_api_mcp_server_original.name}/definitions/${azapi_resource.apicenter_api_mcp_server_original_default_sse.name}"
      server           = { runtimeUri = ["${var.mcp_runtime_uri}"] }
      customProperties = {}
    }
  }
}

resource "null_resource" "api_definition_import_sse" {
  triggers = {
    resource_group_name = var.rg_name
    api_center_name     = var.api_center_name
    api_id              = azapi_resource.apicenter_api_mcp_server.name
    version_id          = azapi_resource.apicenter_api_mcp_server_original.name
    definition_id       = azapi_resource.apicenter_api_mcp_server_original_default_sse.name
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
        "swagger": "2.0",
        "info": {
          "title": "${var.mcp_name}-sse",
          "description": "${var.mcp_description}",
          "version": "1.0.0"
        },
        "host": "${element(split("/", var.mcp_runtime_uri), 2)}",
        "basePath": "/",
        "schemes": [
          "https"
        ],
        "paths": {
          "/sse": {
        "get": {
          "summary": "MCP Server Actions",
          "x-ms-agentic-protocol": "mcp-sse-1.0",
          "operationId": "InvokeMCP"
        }
          }
        },
        "securityDefinitions": {},
        "security": []
      }' \
      --specification '{"name":"openapi","version":"2.0"}'
    EOT
  }
}

resource "time_sleep" "wait_10_seconds" {
  depends_on = [
    null_resource.api_definition_import_sse
  ]
  create_duration = "10s"
}

resource "null_resource" "api_definition_import_streamable" {
  depends_on = [
    time_sleep.wait_10_seconds,
    null_resource.api_definition_import_sse
  ]
  triggers = {
    resource_group_name = var.rg_name
    api_center_name     = var.api_center_name
    api_id              = azapi_resource.apicenter_api_mcp_server.name
    version_id          = azapi_resource.apicenter_api_mcp_server_original.name
    definition_id       = azapi_resource.apicenter_api_mcp_server_original_default_streamable.name
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
        "swagger": "2.0",
        "info": {
          "title": "${var.mcp_name}-streamable",
          "description": "${var.mcp_description}",
          "version": "1.0.0"
        },
        "host": "${element(split("/", var.mcp_runtime_uri), 2)}",
        "basePath": "/",
        "schemes": [
          "https"
        ],
        "paths": {
          "/message": {
        "post": {
          "summary": "MCP Server Actions",
          "x-ms-agentic-protocol": "mcp-streamable-1.0",
          "operationId": "InvokeMCP",
          "responses": {}
        }
          }
        },
        "securityDefinitions": {},
        "security": []
      }' \
      --specification '{"name":"openapi","version":"2.0"}'
    EOT
  }
}
