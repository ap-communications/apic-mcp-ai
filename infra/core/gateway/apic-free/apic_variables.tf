variable "location" {
  description = "The supported Azure location where the resource deployed"
  type        = string
}

variable "rg_name" {
  description = "The name of the resource group to deploy resources into"
  type        = string
}

variable "tags" {
  description = "A list of tags used for deployed services."
  type        = map(string)
}


variable "rg_id" {
  description = "The Resource ID of the resource group to deploy resources into"
  type        = string
}

variable "name" {
  description = "The name of the API Center service"
  type        = string
}

variable "azurerm_client_object_id" {
  description = "The Object ID of the Azure client (user or service principal)"
  type        = string

}

variable "kv_id" {
  description = "The ID of the Key Vault to store secrets"
  type        = string

}
