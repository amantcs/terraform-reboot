
resource "azurerm_resource_group" "app-group" {
  name     = "terra-group"
  location = local.resource_location
}

resource "azurerm_virtual_network" "vnet01" {
  name                = "terra-network-${var.environment}"
  location            = azurerm_resource_group.app-group.location
  resource_group_name = azurerm_resource_group.app-group.name
  address_space       = ["10.0.0.0/16"]

}

resource "azurerm_subnet" "subnet01" {
  name                 = local.subnet_values.subnet_name[0]
  resource_group_name  = azurerm_resource_group.app-group.name
  virtual_network_name = azurerm_virtual_network.vnet01.name
  address_prefixes     = [local.subnet_values.subnet_address_prefix[0]]

}

resource "azurerm_subnet" "subnet02" {
  name                 = local.subnet_values.subnet_name[1]
  resource_group_name  = azurerm_resource_group.app-group.name
  virtual_network_name = azurerm_virtual_network.vnet01.name
  address_prefixes     = [local.subnet_values.subnet_address_prefix[1]]

}

resource "azurerm_network_interface" "nic01" {
  name                = "webinterface01"
  location            = azurerm_resource_group.app-group.location
  resource_group_name = azurerm_resource_group.app-group.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet01.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.pub_ip01.id
  }
}


resource "azurerm_public_ip" "pub_ip01" {
  name                = "webpublicip"
  resource_group_name = azurerm_resource_group.app-group.name
  location            = azurerm_resource_group.app-group.location
  allocation_method   = "Static"
}

resource "azurerm_network_security_group" "nsg01" {
  name                = "terra-nsg"
  location            = azurerm_resource_group.app-group.location
  resource_group_name = azurerm_resource_group.app-group.name
}

resource "azurerm_network_security_rule" "AllowRDP" {
    name                       = "AllowRDP"
    priority                   = 300
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  resource_group_name         = azurerm_resource_group.app-group.name
  network_security_group_name = azurerm_network_security_group.nsg01.name
}

resource "azurerm_network_security_rule" "AllowHTTP" {
    name                       = "AllowHTTP"
    priority                   = 310
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  resource_group_name         = azurerm_resource_group.app-group.name
  network_security_group_name = azurerm_network_security_group.nsg01.name
}

resource "azurerm_subnet_network_security_group_association" "subnet01_nsg" {
  subnet_id                 = azurerm_subnet.subnet01.id
  network_security_group_id = azurerm_network_security_group.nsg01.id
}

resource "azurerm_subnet_network_security_group_association" "subnet02_nsg" {
  subnet_id                 = azurerm_subnet.subnet02.id
  network_security_group_id = azurerm_network_security_group.nsg01.id
}

resource "azurerm_windows_virtual_machine" "example" {
  name                = var.vm_name
  resource_group_name = azurerm_resource_group.app-group.name
  location            = azurerm_resource_group.app-group.location
  size                = var.vm_size
  admin_username      = var.vm_admin_user
  admin_password      = data.azurerm_key_vault_secret.example.value
  network_interface_ids = [
    azurerm_network_interface.nic01.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-Datacenter"
    version   = "latest"
  }
}