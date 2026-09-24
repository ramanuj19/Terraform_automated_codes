variable "snet" {
  type = map(object({
    snet_name             = string
    snet_address_prefixes = list(string)
    vnet_name             = string
    rg_name               = string
  }))
}

# 1. Subnet Deployment
resource "azurerm_subnet" "subnet" {
  for_each             = var.snet
  name                 = each.value.snet_name
  resource_group_name  = each.value.rg_name
  virtual_network_name = each.value.vnet_name
  address_prefixes     = each.value.snet_address_prefixes
}

# 2. Dynamic NSG Container Creation
resource "azurerm_network_security_group" "nsg" {
  for_each            = var.snet
  
  # FIX 1: Variable se nsg_name mangne ke bajaye subnet name ke piche '-nsg' string concat kiya
  name                = "${each.value.snet_name}-nsg" 
  
  # FIX 2: Variable se location mangne ke bajaye directly region hardcode kar diya
  location            = "Central India" 
  
  resource_group_name = each.value.rg_name
}

# 3. Dynamic Association
resource "azurerm_subnet_network_security_group_association" "assoc" {
  for_each                  = var.snet
  subnet_id                 = azurerm_subnet.subnet[each.key].id
  network_security_group_id = azurerm_network_security_group.nsg[each.key].id
}
