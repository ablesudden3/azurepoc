# Create a storage account
resource "azurerm_storage_account" "poc-storage" {
  name                     = var.storage_account_name
  resource_group_name      = var.azurerm_resource_group
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
}

# Create a blob container
resource "azurerm_storage_container" "terraform-container" {
  name                  = "terraformcontainer"
  storage_account_name  = azurerm_storage_account.poc-storage.name
  container_access_type = "blob"
}

# Create an Azure Container Registry

resource "azurerm_container_registry" "poc-acr" {
  name                = "mypocacr2242"
  location            = var.location
  resource_group_name = var.azurerm_resource_group
  sku                 = "Basic"

  admin_enabled = true
}

output "azurerm_container_registry_name" {
  value = azurerm_container_registry.poc-acr.name
}

output "azurerm_container_registry_id" {
  value = azurerm_container_registry.poc-acr.id
}