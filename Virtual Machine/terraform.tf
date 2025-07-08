terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.27.0"
    }
  }

 
  # Configuration options
  backend "azurerm" {
    subscription_id = "b2cc0685-8560-4e34-af78-899f07b85130"
    resource_group_name   = "terraform-rg"
    storage_account_name  = "terrastateus848623976"
    container_name        = "dev"
    key                   = "terraform.tfstate"

}
}

 provider "azurerm" {
    features {}
    tenant_id = "1f9a39c3-19a1-4b99-a7ef-42d8755c192c"
    subscription_id = "b2cc0685-8560-4e34-af78-899f07b85130"
    client_id = "3653b5df-ac94-48c2-9757-cce48e1dce68"
    client_secret = "oog8Q~CZ7iRMOKt6mjxzp0EtomWM2IZ8TIlDlciK"
    
  
  }