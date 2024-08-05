# Creating a resource group
resource "azurerm_resource_group" "sandip-poc" {
  name     = var.azurerm_resource_group
  location = var.location
}