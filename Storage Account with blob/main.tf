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
    client_id = "7da6df51-fa3d-4078-905f-e726ad2fb8dc"
    client_secret = "BAE8Q~nX1BtjAB_e.2pD_5rS4s8q7SvTrh_0HbCt"
    tenant_id = "1f9a39c3-19a1-4b99-a7ef-42d8755c192c"
    subscription_id = "b2cc0685-8560-4e34-af78-899f07b85130"
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


