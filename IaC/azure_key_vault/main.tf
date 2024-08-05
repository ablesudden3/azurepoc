data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "poc-vault" {
  name                        = "poc-vault-20243"
  location                    = var.location
  resource_group_name         = var.azurerm_resource_group
  enabled_for_disk_encryption = true
  tenant_id                   = var.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"
access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get",
    ]

    secret_permissions = [
      "Get","List","Set","Delete",
    ]

    storage_permissions = [
      "Get",
    ]
  }  
}

output "azure_key_vault_id" {
  value = azurerm_key_vault.poc-vault.id
}

output "azure_key_vault_name" {
  value = azurerm_key_vault.poc-vault.name
}

