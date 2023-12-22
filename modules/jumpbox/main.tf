locals {
  component = "novacp-${var.environment}-${var.region_short}-nexus"
}

resource "azurerm_resource_group" "jumpbox_rg" {
  name     = "${local.component}-jumpbox-rg"
  location = var.region
}

# Public IP
resource "azurerm_public_ip" "jumpbox_publicip" {
  name                = "${local.component}-jumpbox-publicip"
  resource_group_name = azurerm_resource_group.jumpbox_rg.name
  location            = azurerm_resource_group.jumpbox_rg.location
  allocation_method   = "Dynamic"
}

# Network interface
resource "azurerm_network_interface" "jumpbox_nic" {
  name                = "${local.component}-jumpbox-nic"
  resource_group_name = azurerm_resource_group.jumpbox_rg.name
  location            = azurerm_resource_group.jumpbox_rg.location

  ip_configuration {
    name                          = "public"
    subnet_id                     = var.jumpbox_subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.jumpbox_publicip.id
  }
}

# Virtual machine
resource "azurerm_windows_virtual_machine" "jumpbox" {
  name                = "${local.component}-jumpbox"
  resource_group_name = azurerm_resource_group.jumpbox_rg.name
  location            = azurerm_resource_group.jumpbox_rg.location
  size                = var.jumpbox_vm_size
  computer_name       = "nexus-jumpbox"
  admin_username      = var.jumpbox_username
  admin_password      = var.jumpbox_password
  network_interface_ids = [
    azurerm_network_interface.jumpbox_nic.id,
  ]

  os_disk {
    name                 = "${local.component}-jumpbox-disk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = 30
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
}
