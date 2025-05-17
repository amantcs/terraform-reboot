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