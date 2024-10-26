resource "azurerm_resource_group" "appgrp" {
  name     = "${terraform.workspace}-grp"
  location = local.location
}


resource "azurerm_virtual_network" "network" {

  name                = "${terraform.workspace}network"
  location            = local.location
  resource_group_name = azurerm_resource_group.appgrp.name
  address_space       = [local.address_space.staging]
 
  depends_on = [ azurerm_resource_group.appgrp ]



  }

resource "azurerm_subnet" "subnet" {    
    name                 = "${terraform.workspace}Subnet"
    resource_group_name  = azurerm_resource_group.appgrp.name
    virtual_network_name = azurerm_virtual_network.network.name
    address_prefixes     = [cidrsubnet(local.address_space.staging, 8, 0)]
    depends_on = [
      azurerm_virtual_network.network
    ]
}

resource "azurerm_network_security_group" "appnsg" {
  name                = "${terraform.workspace}-nsg"
  location            = local.location 
  resource_group_name = azurerm_resource_group.appgrp.name

  security_rule {
    name                       = "AllowRDP"
    priority                   = 300
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowHTTP"
    priority                   = 400
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

depends_on = [
    azurerm_virtual_network.network
  ]
}

resource "azurerm_subnet_network_security_group_association" "nsglink" {
 
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.appnsg.id

  depends_on = [ azurerm_network_security_group.appnsg, azurerm_subnet.subnet ]
}

resource "azurerm_subnet" "subnetB" {    
    name                 = "${terraform.workspace}SubnetB"
    resource_group_name  = azurerm_resource_group.appgrp.name
    virtual_network_name = azurerm_virtual_network.network.name
    address_prefixes     = [cidrsubnet(local.address_space.staging, 8, 1)]
    depends_on = [
      azurerm_virtual_network.network
    ]
}





