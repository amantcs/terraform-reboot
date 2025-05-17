

resource "azurerm_resource_group" "app-group" {
  name     = "terra-group-01"
  location = "West Europe"
}



resource "azurerm_storage_account" "meharstore783475278" {
  count = 3
  name                     = "${count.index}meharstore783475278"
  resource_group_name      = azurerm_resource_group.app-group.name
  location                 = azurerm_resource_group.app-group.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}


resource "azurerm_storage_container" "container01" {
  for_each = toset(["data", "platform", "appdev"])
  name                  = each.key
  storage_account_id    = azurerm_storage_account.meharstore783475278[0].id
  container_access_type = "container"
}

resource "azurerm_storage_blob" "blob01" {
  name                   = "LOU_Amandeep.pdf"
  storage_account_name   = azurerm_storage_account.meharstore783475278[0].name
  storage_container_name = azurerm_storage_container.container01["platform"].name
  type                   = "Block"
  source                 = "LOU_Amandeep.pdf"
}


