
/*
resource "azurerm_bastion_host" "poc-bastion" {
  name                = "poc-bastion"
  location            = var.location
  resource_group_name = var.azurerm_resource_group

  ip_configuration {
    name                 = "poc-ip-configuration"
    subnet_id            = var.subnet_id
    public_ip_address_id = azurerm_public_ip.poc-pip.id
  }
}
*/
data "azurerm_key_vault_secret" "admin_login_vm" {
  name         = "adminuser"
  key_vault_id = var.key_vault_id
}

data "azurerm_key_vault_secret" "admin_password_vm" {
  name         = "vmpass"
  key_vault_id = var.key_vault_id
}

resource "azurerm_windows_virtual_machine" "poc-vm" {
  name                = "poc-win-machine"
  resource_group_name = var.azurerm_resource_group
  location            = var.location
  size                = "Standard_D2s_v3"
  admin_username      = "adminuser"
  admin_password      = "P@$$w0rd1234!"
  network_interface_ids = [
    var.network_interface_ids,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsDesktop"
    offer     = "windows-11"
    sku       = "win11-21h2-pro"
    version   = "latest"
  }

}

/*

resource "azurerm_virtual_machine" "poc-vm" {
  name                  = "poc-vm"
  location              = var.location
  resource_group_name   = var.azurerm_resource_group
  network_interface_ids = var.network_interface_ids
  vm_size               = "Standard_B1s"

  storage_os_disk {
    name              = "poc-os-disk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  os_profile {
    computer_name  = "poc-vm"
    admin_username = data.azurerm_key_vault_secret.admin_login_vm.value
    admin_password = data.azurerm_key_vault_secret.admin_password_vm.value  # Secure this or use SSH keys
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  tags = {
    environment = "test"
  }
}
*/