terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.27.0"
    }
  }

 
  # Configuration options
  #backend "azurerm" {
  #  subscription_id = "b2cc0685-8560-4e34-af78-899f07b85130"
  #  resource_group_name   = "terraform-rg"
  #  storage_account_name  = "terrastateus848623976"
  #  container_name        = "dev"
  #  key                   = "terraform.tfstate"

#}
}

 provider "azurerm" {
    features {}
    subscription_id = "34b6d612-0e83-4362-97a7-ae95e493643a"
    
  
  }
