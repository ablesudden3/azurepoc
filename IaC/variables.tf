variable "client_id" {
  type      = string
  sensitive = true
}

variable "client_secret" {
  type      = string
  sensitive = true
}

variable "tenant_id" {
  type      = string
  sensitive = true
}

variable "subscription_id" {
  type = string
}

variable "azurerm_resource_group" {
  type = string
}

variable "location" {
  type        = string
  description = "Location for the azure cloud resources"
}
variable "storage_account_name" {
  type = string
}

variable "vnet_name" {
  type = string
}

variable "address_space" {
  type = list(any)
}




