data "azurerm_key_vault_secret" "admin_login" {
  name         = "dbuser"
  key_vault_id = var.key_vault_id
}

data "azurerm_key_vault_secret" "admin_password" {
  name         = "dbpassword"
  key_vault_id = var.key_vault_id
}

resource "azurerm_private_dns_zone" "poc-dns-zone" {
  name                = "poc-dns-zone.postgres.database.azure.com"
  resource_group_name = var.azurerm_resource_group
}

resource "azurerm_private_dns_zone_virtual_network_link" "poc-dns-zone-network-link" {
  name                  = "pocvnetzone.com"
  private_dns_zone_name = azurerm_private_dns_zone.poc-dns-zone.name
  virtual_network_id    = var.virtual_network_id
  resource_group_name   = var.azurerm_resource_group
}

resource "azurerm_postgresql_flexible_server" "poc-db" {
  name                = "postgresql-server-2135"
  location            = var.location
  resource_group_name = var.azurerm_resource_group

  sku_name = "B_Standard_B1ms"

  storage_mb                    = 32768
  backup_retention_days         = 7
  geo_redundant_backup_enabled  = false
  auto_grow_enabled             = true
  administrator_login           = data.azurerm_key_vault_secret.admin_login.value
  administrator_password        = data.azurerm_key_vault_secret.admin_password.value
  version                       = "16"
  delegated_subnet_id           = var.subnet_id
  private_dns_zone_id           = azurerm_private_dns_zone.poc-dns-zone.id
  public_network_access_enabled = false
  depends_on                    = [azurerm_private_dns_zone_virtual_network_link.poc-dns-zone-network-link]
}

resource "azurerm_postgresql_flexible_server_database" "exampledb" {
  name      = "exampledb"
  server_id = azurerm_postgresql_flexible_server.poc-db.id
  charset   = "UTF8"
}