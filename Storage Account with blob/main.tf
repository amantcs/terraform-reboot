terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.27.0"
    }
  }
}

provider "azurerm" {
    features {}
    subscription_id = "34b6d612-0e83-4362-97a7-ae95e493643a"
  # Configuration options
}

resource "azurerm_resource_group" "app-group" {
  name     = "terra-group"
  location = "West Europe"
}

resource "azurerm_storage_container" "container01" {
  name                  = "meharcontainer"
  storage_account_id    = azurerm_storage_account.meharstore783475278.id
  container_access_type = "container"
}

resource "azurerm_storage_blob" "blob01" {
  name                   = "LOU_Amandeep.pdf"
  storage_account_name   = azurerm_storage_account.meharstore783475278.name
  storage_container_name = azurerm_storage_container.container01.name
  type                   = "Block"
  source                 = "LOU_Amandeep.pdf"
}

resource "azurerm_storage_account" "meharstore783475278" {
  name                     = "meharstore783475278"
  resource_group_name      = azurerm_resource_group.app-group.name
  location                 = azurerm_resource_group.app-group.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "staging"
  }
}


