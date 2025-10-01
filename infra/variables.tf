# Input variables for the module

# APICの利用可能リージョンに制限(2025/10現在)
# https://learn.microsoft.com/ja-jp/azure/api-center/overview#available-regions
variable "location" {
  description = "The supported Azure location where the resource deployed"
  type        = string
  validation {
    condition = contains([
      "australiaeast",
      "canadacentral",
      "centralindia",
      "eastus",
      "francecentral",
      "swedencentral",
      "uksouth",
      "westeurope"
    ], lower(var.location))
    error_message = "location must be one of: australiaeast, canadacentral, centralindia, eastus, francecentral, swedencentral, uksouth, westeurope"
  }
}

variable "environment_name" {
  description = "The name of the azd environment to be deployed"
  type        = string
}

variable "subscription_id" {
  description = "The subscription ID to deploy the resources"
  type        = string
}

variable "apim_name" {
  description = "The name of the API Management instance"
  type        = string
}

variable "apim_rg_name" {
  description = "The name of the resource group containing the APIM instance"
  type        = string
}

variable "github_repo" {
  description = "The GitHub repository to be used for the deployment"
  type        = string
}

variable "github_owner" {
  description = "The GitHub repository owner to be used for the deployment"
  type        = string

}
