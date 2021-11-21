# Create the virtual machine. Use the "count" variable to define how many
# to create.
resource "azurerm_linux_virtual_machine" "virtualmachine" {
  count                           = 1
  name                            = title("${var.prefix}_machine_num_${count.index + 1}")
  admin_username                  = var.admin_username
  admin_password                  = random_password.dpasswrd.result
  computer_name                   = title("${var.specs["default"]["comp_name"]}-${count.index + 1}")
  location                        = var.resourcegroup_location
  resource_group_name             = var.resourcegroup_name
  size                            = var.specs["default"]["instance_type"]
  disable_password_authentication = false


  network_interface_ids = [
    element(azurerm_network_interface.Management.*.id, count.index),
    element(azurerm_network_interface.Untrust.*.id, count.index),
    element(azurerm_network_interface.Trust.*.id, count.index),
  ]

  # F5 resources
  source_image_reference {
    publisher = var.specs["default"]["publisher"]
    offer     = var.specs["default"]["offer"]
    sku       = var.specs["default"]["sku"]
    version   = var.specs["default"]["f5version"]
  }

  plan {
    name      = var.specs["default"]["plan_name"]
    product   = var.specs["default"]["product"]
    publisher = var.specs["default"]["publisher"]
  }

  #Disk
  os_disk {
    name                 = "${var.prefix}-osdisk-${count.index}"
    storage_account_type = var.specs["default"]["storage_type"]
    caching              = "ReadWrite"
  }
}

resource "azurerm_network_security_group" "security_gr" {
  location            = var.resourcegroup_location
  resource_group_name = var.resourcegroup_name
  name                = "${var.prefix}-sg"

  security_rule {
    name                       = "HTTP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "HTTPS"
    priority                   = 102
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "SSH"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

