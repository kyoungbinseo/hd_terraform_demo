data "azurerm_shared_image_version" "image_rhel76" {
  name                = "0.0.1"
  image_name          = "rhel76-definition"
  gallery_name        = "rhel76"
  resource_group_name = "het_manager1_dev_rhel76_RG"
}

data "azurerm_shared_image_version" "image_rhel85" {
  name                = "0.0.1"
  image_name          = "rhel85"
  gallery_name        = "bsnc"
  resource_group_name = "bsnc-01-rg"
}

data "azurerm_resource_group" "dev_rg" {
  name = "ksoe-terraform-prod-rg"
}

data "azurerm_resource_group" "subnet_rg" {
  name = "hhi-devvm-migration-rg"
}

data "azurerm_subnet" "example_subnet" {
  name                 = "hhi-devlinux-vnet03-ks-sn01" # 서브넷 이름
  virtual_network_name = "hhi-devlinux-vnet03-ks"      # Virtual Network 이름
  resource_group_name  = data.azurerm_resource_group.subnet_rg.name
}