terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
}

provider "azurerm" {
  features {
    virtual_machine {
      skip_shutdown_and_force_delete = true
    }
  }
}

resource "azurerm_resource_group" "terraformResourceGroup" {
  name     = "ksoe-terraform-rg"
  location = "Korea South"
}

resource "azurerm_network_interface" "example-network-interface" {
  for_each            = var.vm_configurations
  name                = "${each.value.name}-nic"
  location            = azurerm_resource_group.terraformResourceGroup.location
  resource_group_name = azurerm_resource_group.terraformResourceGroup.name

  ip_configuration {
    name                          = "${each.value.name}-ipconfig"
    subnet_id                     = "/subscriptions/59c5f466-6594-4763-abf5-e42ffb270016/resourceGroups/hhi-devvm-migration-rg/providers/Microsoft.Network/virtualNetworks/hhi-devlinux-vnet03-ks/subnets/hhi-devlinux-vnet03-ks-sn01"
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "example-vm" {
  for_each                        = var.vm_configurations
  name                            = each.value.name
  location                        = azurerm_resource_group.terraformResourceGroup.location
  resource_group_name             = azurerm_resource_group.terraformResourceGroup.name
  network_interface_ids = [azurerm_network_interface.example-network-interface[each.key].id]# ✅ 각 key에 해당하는 NIC 참조
  size                            = each.value.size
  admin_username                  = each.value.username
  admin_password                  = each.value.password
  disable_password_authentication = false

  os_disk {
    name                 = "${each.value.name}-os-disk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_id = var.os_images[each.value.tags.os]

  tags = each.value.tags

  boot_diagnostics {}

}

resource "azurerm_dev_test_global_vm_shutdown_schedule" "example-shutdown" {
  for_each = var.vm_configurations
  location              = azurerm_resource_group.terraformResourceGroup.location
  virtual_machine_id    = azurerm_linux_virtual_machine.example-vm[each.key].id
  enabled               = true
  daily_recurrence_time = "1800"
  timezone              = "Korea Standard Time"

  notification_settings {
    enabled         = false
    time_in_minutes = null
    webhook_url     = null
  }

}