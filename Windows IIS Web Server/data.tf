data "azurerm_key_vault" "example" {
  name                = "amanahead"
  resource_group_name = "security-rg"
}

data "azurerm_key_vault_secret" "example" {
  name         = "vmpassword"
  key_vault_id = data.azurerm_key_vault.example.id
}