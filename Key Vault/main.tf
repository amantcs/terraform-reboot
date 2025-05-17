
resource "azurerm_resource_group" "app-group-kv" {
  name     = "terra-group-kv"
  location = "West Europe"
}



resource "azurerm_key_vault" "example" {
  name                        = "examplekeyvault98348936"
  location                    = azurerm_resource_group.app-group-kv.location
  resource_group_name         = azurerm_resource_group.app-group-kv.name
  tenant_id                   = "cc9742cd-dcca-4219-abba-51ebf8d39cc6"
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false
  sku_name = "standard"

}