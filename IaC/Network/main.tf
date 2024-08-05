resource "azurerm_virtual_network" "poc-vnet" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.azurerm_resource_group
  address_space       = var.address_space
}

output "virtual_network_id" {
  value = azurerm_virtual_network.poc-vnet.id
}

resource "azurerm_subnet" "k8_subnet" {
  name                 = "k8-subnet"
  resource_group_name  = var.azurerm_resource_group
  virtual_network_name = azurerm_virtual_network.poc-vnet.name
  address_prefixes     = ["192.168.0.0/22"]
}

output "subnet_id_k8_subnet" {
  value = azurerm_subnet.k8_subnet.id
}

resource "azurerm_subnet" "AzureBastionSubnet" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = var.azurerm_resource_group
  virtual_network_name = azurerm_virtual_network.poc-vnet.name
  address_prefixes     = ["192.168.4.0/24"]
}

output "subnet_id_bastionhost" {
  value = azurerm_subnet.AzureBastionSubnet.id
}

resource "azurerm_subnet" "vm-subnet" {
  name                 = "vm-subnet"
  resource_group_name  = var.azurerm_resource_group
  virtual_network_name = azurerm_virtual_network.poc-vnet.name
  address_prefixes     = ["192.168.5.0/24"]
}

resource "azurerm_subnet" "db-subnet" {
  name                 = "db-subnet"
  resource_group_name  = var.azurerm_resource_group
  virtual_network_name = azurerm_virtual_network.poc-vnet.name
  address_prefixes     = ["192.168.7.0/24"]

    delegation {
    name = "delegation"

    service_delegation {
      name    = "Microsoft.DBforPostgreSQL/flexibleServers"
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action"]
    }
  }
}

output "subnet_id_db-subnet" {
  value = azurerm_subnet.db-subnet.id
}

resource "azurerm_public_ip" "poc-pip" {
  name                = "poc-public-ip"
  location            = var.location
  resource_group_name = var.azurerm_resource_group
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_network_security_group" "poc-nsg" {
  name                = "my-poc-nsg"
  location            = var.location
  resource_group_name = var.azurerm_resource_group

  security_rule {
    name                       = "allow_rdp"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "49.37.37.143"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow_http"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}


resource "azurerm_network_interface" "main" {
  name                = "my--poc-nic"
  location            = var.location
  resource_group_name = var.azurerm_resource_group

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = azurerm_subnet.vm-subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.poc-pip.id
  }
}

output "network_interface_ids" {
  value = azurerm_network_interface.main.id

}
