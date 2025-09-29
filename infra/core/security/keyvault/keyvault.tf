terraform {
  required_providers {
    azurerm = {
      version = "~>4.42.0"
      source  = "hashicorp/azurerm"
    }
  }
}


resource "azurerm_key_vault" "kv" {
  name                       = var.name
  location                   = var.location
  resource_group_name        = var.rg_name
  tenant_id                  = var.tenant_id
  purge_protection_enabled   = false
  sku_name                   = "standard"
  rbac_authorization_enabled = true

  tags = var.tags
}

resource "azurerm_role_assignment" "kv_admin" {
  scope                = azurerm_key_vault.kv.id
  role_definition_name = "Key Vault Administrator"
  principal_id         = var.principal_id
}

resource "azurerm_key_vault_secret" "secrets" {
  count        = length(var.secrets)
  name         = var.secrets[count.index].name
  value        = var.secrets[count.index].value
  key_vault_id = azurerm_key_vault.kv.id
  depends_on = [
    azurerm_role_assignment.kv_admin,
  ]
}
