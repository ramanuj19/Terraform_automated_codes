variable "vm" {
  
}

resource "azurerm_network_interface" "nic" {
  for_each = var.vm
  name                = each.value.nic_name
  location            = each.value.vm_location
  resource_group_name = each.value.rg_name
  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.subnet[each.key].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = data.azurerm_public_ip.pubip[each.key].id
  }
}
resource "azurerm_linux_virtual_machine" "virtual_machine" {
  for_each = var.vm
  name                = each.value.vm_name
  resource_group_name = each.value.rg_name
  location            = each.value.vm_location
  size                = each.value.vm_size
  admin_username      = each.value.admin_username
  network_interface_ids = [azurerm_network_interface.nic[each.key].id]
  disable_password_authentication = false
  admin_password                  = each.value.admin_password
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
}