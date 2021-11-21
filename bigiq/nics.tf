
# Create the public IP address
resource "azurerm_public_ip" "pip" {
  count               = 1
  name                = "pip-${count.index}-mgmt"
  location            = var.resourcegroup_location
  resource_group_name = var.resourcegroup_name
  allocation_method   = "Dynamic"
}

# Create the network interfaces
resource "azurerm_network_interface" "Management" {
  count               = 1
  name                = "nic-${count.index}-mgmt"
  location            = var.resourcegroup_location
  resource_group_name = var.resourcegroup_name

  ip_configuration {
    name                          = "mgmt-${count.index}-ip-0"
    subnet_id                     = var.management_subnet_ids[0]
    private_ip_address_allocation = "dynamic"
    public_ip_address_id          = element(azurerm_public_ip.pip.*.id, count.index)
    primary                       = "true"
  }
}

# Create the network interfaces
resource "azurerm_network_interface" "Untrust" {
  count               = 1
  name                = "nic-${count.index}-untrust"
  location            = var.resourcegroup_location
  resource_group_name = var.resourcegroup_name
  #enable_ip_forwarding = "true"

  ip_configuration {
    name                          = "untrust-${count.index}-ip-0"
    subnet_id                     = var.public_subnet_ids[0]
    private_ip_address_allocation = "dynamic"
  }
}

# Create the network interfaces
resource "azurerm_network_interface" "Trust" {
  count               = 1
  name                = "nic-${count.index}-trust"
  location            = var.resourcegroup_location
  resource_group_name = var.resourcegroup_name
  #enable_ip_forwarding = "true"

  ip_configuration {
    name                          = "nic-${count.index}-ip-0"
    subnet_id                     = var.private_subnet_ids[0]
    private_ip_address_allocation = "Static"
    private_ip_address            = cidrhost(cidrsubnet(var.cidr,8,30),14)
  }
}
# Create the availability set
# resource "azurerm_availability_set" "demo" {
#   name                = "as-fw"
#   location            = azurerm_resource_group.demo.location
#   resource_group_name = azurerm_resource_group.demo.name
#platform_update_domain_count = "5"
#platform_fault_domain_count  = "1"
#}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "jointogether_networks" {
  count                     = 1
  network_interface_id      = element(azurerm_network_interface.Management.*.id, count.index)
  network_security_group_id = element(azurerm_network_security_group.security_gr.*.id, count.index)
}
