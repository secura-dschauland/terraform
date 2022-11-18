terraform {
  backend "azurerm" {
    subscription_id      = "737acae0-f9d8-421f-bddb-3c7ee659a32c"
    resource_group_name  = "rg-shared-storage-northcentralus"
    storage_account_name = "sasecuraterraformstate"
    container_name       = "purview-poc-tfstate"
    key                  = "terraform.tfstate"
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.24.0"
    }
  }
}

provider "azurerm" {
  features {}
}
