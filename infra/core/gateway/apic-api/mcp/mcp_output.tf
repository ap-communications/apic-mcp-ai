output "mcp_api_id" {
  description = "The ID of the MCP API"
  value       = azapi_resource.apicenter_api_mcp_server.id
}

output "mcp_api_name" {
  description = "The name of the MCP API"
  value       = azapi_resource.apicenter_api_mcp_server.name
}

output "mcp_api_version_id" {
  description = "The ID of the MCP API version"
  value       = azapi_resource.apicenter_api_mcp_server_original.id
}

output "mcp_api_deployment_id" {
  description = "The ID of the MCP API deployment"
  value       = azapi_resource.apicenter_api_mcp_server_deployment.id
}

output "mcp_sse_definition_id" {
  description = "The ID of the MCP SSE definition"
  value       = azapi_resource.apicenter_api_mcp_server_original_default_sse.id
}

output "mcp_streamable_definition_id" {
  description = "The ID of the MCP streamable definition"
  value       = azapi_resource.apicenter_api_mcp_server_original_default_streamable.id
}
