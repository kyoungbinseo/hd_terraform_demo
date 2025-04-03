resource "azurerm_storage_account" "example" {
  # 고유 키 생성 (계정명 기준)
  for_each = { for storage in var.storages : storage.storage_account_name => storage }

  name                     = each.value.storage_account_name
  resource_group_name      = data.azurerm_resource_group.dev_rg.name
  location                 = data.azurerm_resource_group.dev_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "example" {
  for_each = { for storage in var.storages : storage.storage_account_name => storage }

  name                  = each.value.container_name
  storage_account_name  = azurerm_storage_account.example[each.key].name
  container_access_type = "private"
}
