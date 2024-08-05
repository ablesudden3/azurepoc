variable "azurerm_resource_group" {
  type = string
}

variable "vnet_name" {
  type = string
}

variable "address_space" {
  type = list(any)
}

variable "location" {
  type        = string
  description = "Location for the azure cloud resources"
}