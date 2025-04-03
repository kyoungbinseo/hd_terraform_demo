
resource "azurerm_network_interface" "example-network-interface" {
  for_each            = { for vm in var.vm_configurations : vm.name => vm }
  name                = "${each.value.name}-nic"
  location            = data.azurerm_resource_group.dev_rg.location
  resource_group_name = data.azurerm_resource_group.dev_rg.name

  ip_configuration {
    name                          = "${each.value.name}-ipconfig"
    subnet_id                     = data.azurerm_subnet.example_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "example-vm" {
  for_each                        = { for vm in var.vm_configurations : vm.name => vm }
  name                            = each.value.name
  location                        = data.azurerm_resource_group.dev_rg.location
  resource_group_name             = data.azurerm_resource_group.dev_rg.name
  network_interface_ids           = [azurerm_network_interface.example-network-interface[each.key].id] # ✅ 각 key에 해당하는 NIC 참조
  size                            = each.value.size
  admin_username                  = each.value.username
  admin_password                  = each.value.password
  disable_password_authentication = false


  os_disk {
    name                 = "${each.value.name}-os-disk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_id = data.azurerm_shared_image_version.image_rhel85.id

  tags = each.value.tags

  boot_diagnostics {}

}