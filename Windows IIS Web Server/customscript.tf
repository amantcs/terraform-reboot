resource "azurerm_storage_account" "meharstore783475278" {
  name                     = "meharstore765878374983"
  resource_group_name      = azurerm_resource_group.app-group.name
  location                 = azurerm_resource_group.app-group.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}


resource "azurerm_storage_container" "container01" {
  name                  = "container01"
  storage_account_id    = azurerm_storage_account.meharstore783475278.id
  container_access_type = "container"
}

resource "azurerm_storage_blob" "blob01" {
  name                   = "IIS.ps1"
  storage_account_name   = azurerm_storage_account.meharstore783475278.name
  storage_container_name = azurerm_storage_container.container01.name
  type                   = "Block"
  source                 = "IIS.ps1"
}

resource "azurerm_virtual_machine_extension" "example" {
  name                 = "hostname"
  virtual_machine_id   = azurerm_windows_virtual_machine.example.id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.9"

  settings = <<SETTINGS
 {
        "fileUris": ["https://${azurerm_storage_account.meharstore783475278.name}.blob.core.windows.net/${azurerm_storage_container.container01.name}/${azurerm_storage_blob.blob01.source}"],
          "commandToExecute": "powershell -ExecutionPolicy Unrestricted -file ${azurerm_storage_blob.blob01.source}"     
    }
SETTINGS

}