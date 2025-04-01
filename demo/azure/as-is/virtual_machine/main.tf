terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "terraformResourceGroup" {
    name = "ksoe-terraform-rg"
    location = "Korea South"
}

resource "azurerm_network_interface" "example-network-interface" {
    name = "example-nic"
    location = azurerm_resource_group.terraformResourceGroup.location
    resource_group_name = azurerm_resource_group.terraformResourceGroup.name

    ip_configuration {
      name = "example-ipconfig"
      subnet_id = "/subscriptions/59c5f466-6594-4763-abf5-e42ffb270016/resourceGroups/hhi-devvm-migration-rg/providers/Microsoft.Network/virtualNetworks/hhi-devlinux-vnet03-ks/subnets/hhi-devlinux-vnet03-ks-sn01"
      private_ip_address_allocation = "Dynamic"
    }
}

resource "azurerm_linux_virtual_machine" "example-vm" {
    name = "example-vm"
    location = azurerm_resource_group.terraformResourceGroup.location
    resource_group_name = azurerm_resource_group.terraformResourceGroup.name
    network_interface_ids = [azurerm_network_interface.example-network-interface.id]
    size = "Standard_DS1_v2"
    admin_username = "tester"
    admin_password = "1234qwerAS!"
    disable_password_authentication = false

    os_disk {
      name = "example-os-disk"
      caching = "ReadWrite"
      storage_account_type = "Standard_LRS"
    }

    source_image_id = "/subscriptions/59c5f466-6594-4763-abf5-e42ffb270016/resourceGroups/bsnc-01-rg/providers/Microsoft.Compute/galleries/bsnc/images/rhel85"

    tags = {
      company = "ksoe"
      team = "클라우드추진팀"
      manage = "최규현"
      os = "rhel8.5"
      code = "test"
      purpose = "terraform 실습"
    }

    boot_diagnostics {}

}

resource "azurerm_dev_test_global_vm_shutdown_schedule" "example-shutdown" {
    location = azurerm_resource_group.terraformResourceGroup.location
    virtual_machine_id = azurerm_linux_virtual_machine.example-vm.id
    enabled = true
    daily_recurrence_time = "1800"
    timezone = "Korea Standard Time"

    notification_settings {
      enabled = false
      time_in_minutes = null
      webhook_url = null
    }
  
}