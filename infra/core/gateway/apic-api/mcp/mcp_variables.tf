variable "mcp_name" {
  description = "The name of the MCP server"
  type        = string
}

variable "mcp_description" {
  description = "The description of the MCP server"
  type        = string
}

variable "apicenter_workspace_id" {
  description = "The ID of the API Center workspace"
  type        = string
}

variable "mcp_env_name" {
  description = "The environment name for MCP deployment"
  type        = string
}

variable "mcp_runtime_uri" {
  description = "The runtime URI for the MCP server"
  type        = string
}

variable "rg_name" {
  description = "The name of the resource group"
  type        = string
}

variable "api_center_name" {
  description = "The name of the API Center service"
  type        = string
}
