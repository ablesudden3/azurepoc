module "storage" {
  source                 = "./storage"
  storage_account_name   = var.storage_account_name
  location               = var.location
  azurerm_resource_group = azurerm_resource_group.sandip-poc.name
}

module "network" {
  source                 = "./Network"
  vnet_name              = var.vnet_name
  address_space          = var.address_space
  location               = var.location
  azurerm_resource_group = azurerm_resource_group.sandip-poc.name

}

module "azure_key_vault" {
  source                 = "./azure_key_vault"
  location               = var.location
  azurerm_resource_group = azurerm_resource_group.sandip-poc.name
  tenant_id              = var.tenant_id
}

module "compute" {
  source                        = "./Compute"
  vnet_name                     = var.vnet_name
  location                      = var.location
  azurerm_resource_group        = azurerm_resource_group.sandip-poc.name
  subnet_id                     = module.network.subnet_id_k8_subnet
  virtual_network_id            = module.network.virtual_network_id
  network_interface_ids         = module.network.network_interface_ids
  key_vault_id                  = module.azure_key_vault.azure_key_vault_id
  azurerm_container_registry    = module.storage.azurerm_container_registry_name
  azurerm_container_registry_id = module.storage.azurerm_container_registry_id
  depends_on                    = [module.network]
}

module "database" {
  source                 = "./Database"
  vnet_name              = var.vnet_name
  location               = var.location
  key_vault_id           = module.azure_key_vault.azure_key_vault_id
  virtual_network_id     = module.network.virtual_network_id
  azurerm_resource_group = azurerm_resource_group.sandip-poc.name
  subnet_id              = module.network.subnet_id_db-subnet
  depends_on             = [module.network]
}