terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "5.0.0"
    }
  }
  backend "azurerm" {
    storage_account_name = "axionflexstorage"
    resource_group_name  = "rg-axion-storage"
    container_name       = "tfstate"
    key                  = "axionflexstorage.tfstate"
  }
}

provider "azurerm" {
  features {}
  subscription_id = "03f17a94-45cc-4684-9320-c16a4262957f"
}