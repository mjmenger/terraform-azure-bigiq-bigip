module bigip {
    count                      = length(var.azs)
    source                     = "F5Networks/bigip-module/azure"
    version                    = "1.1.0"
    prefix                     = format("%s-bigip-%s",var.prefix,"abcd")
    f5_ssh_publickey           = file("~/.ssh/id_rsa.pub")
    resource_group_name        = var.resourcegroup_name
    mgmt_subnet_ids            = [{"subnet_id" =  var.management_subnet_ids[count.index], "public_ip" = true, "private_ip_primary" = "", "private_ip_secondary" = "" }]
    mgmt_securitygroup_ids     = [azurerm_network_security_group.management_sg.id]
    external_subnet_ids        = [{ "subnet_id" = var.public_subnet_ids[count.index], "public_ip" = true, "private_ip_primary" = "", "private_ip_secondary" = "" }]
    external_securitygroup_ids = [azurerm_network_security_group.application_sg.id]
    internal_subnet_ids        = [{ "subnet_id" = var.private_subnet_ids[count.index], "public_ip" = false, "private_ip_primary" = "" }]
    internal_securitygroup_ids = [azurerm_network_security_group.management_sg.id]
    availabilityZones          = [var.azs[count.index]]
    tags                       = {owner = "menger"}
}




# Create Network Security Group and rule
resource "azurerm_network_security_group" "management_sg" {
    name                = format("%s-mgmt_sg-%s",var.prefix,random_id.randomId.hex)
    location            = var.resourcegroup_location
    resource_group_name = var.resourcegroup_name
    
    security_rule {
        name                       = "SSH"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = var.allowed_mgmt_cidr
        destination_address_prefix = "*"
    }

    security_rule {
        name                       = "HTTPS"
        priority                   = 1002
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = var.allowed_mgmt_cidr
        destination_address_prefix = "*"
    }

    security_rule {
        name                       = "SSH-internal"
        priority                   = 1003
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = var.cidr
        destination_address_prefix = "*"
    }

    security_rule {
        name                       = "HTTPS-internal"
        priority                   = 1004
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = var.cidr
        destination_address_prefix = "*"
    }

    tags = {
        environment = var.environment
    }
}


# Create Application Traffic Network Security Group and rule
resource "azurerm_network_security_group" "application_sg" {
    name                = format("%s-application_sg-%s",var.prefix,random_id.randomId.hex)
    location            = var.resourcegroup_location
    resource_group_name = var.resourcegroup_name

    security_rule {
        name                       = "HTTPS"
        priority                   = 1002
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    security_rule {
        name                       = "HTTP"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    tags = {
        environment = var.environment
    }
}
