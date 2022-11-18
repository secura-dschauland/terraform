# configure backend 
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "rg-core-shared-nocnus-001"
    storage_account_name = "scvwan"
    container_name       = "vwan-tfstate"
    key                  = "terraform.tfstate"
  }
}

# configure provider(s)
provider "azurerm" {

  subscription_id = "7d095679-9a86-45cb-8de8-082ea2a9d5ae"
  features {}
}

provider "azurerm" {
  alias = "aznet"

  subscription_id = "737acae0-f9d8-421f-bddb-3c7ee659a32c"
  features {}
}

# configure locals for this project
locals {
  location = var.location

  req_tags = {
    solution    = var.req_tags.solution_tag
    department  = var.req_tags.department_tag
    owner       = var.req_tags.owner_tag
    environment = var.req_tags.environment_tag
  }

  naming_items              = trim(lower("${local.req_tags.environment}-${local.req_tags.solution}"), " ")
  naming_items2             = trim(lower("${local.req_tags.environment}"), " ")
  neenah_vpn_site_link_name = "vpn-site-${var.vpn_link_names[0]}"
  dc_vpn_site_link_name     = "vpn-site-${var.vpn_link_names[1]}"

  is_neenah = length(regexall(".*neenah,*", local.neenah_vpn_site_link_name)) > 0

  secret_map = {
    tfstate-access-key = data.azurerm_key_vault_secret.storagekey.value
    vwan-psk = data.azurerm_key_vault_secret.psk.value
  }


}
#Another Note: Existing resources that are not built in terraform can be imported using the terraform import command
#Write config for a resource that already exists, run terraform import, and then terraform plan will update the existing object if there are changes
#These steps are super important and can be annoying if there are child objects, terraform would destroy the child objects if you don't write resource blocks and import them

# collect naming module items
module "naming" {
  source  = "Azure/naming/azurerm"
  version = "0.2.0"
}

#Existing Resources - not managed by TF 
data "azurerm_resource_group" "rg" {
  name = "rg-core-shared-nocnus-001"

}

data "azurerm_resource_group" "networkrg" {
  name     = "rg-NetworkingTest-nocnus-001"
  provider = azurerm.aznet
}

data "azurerm_key_vault" "kv" {
  name                = "kv-it-nonprod-tfstate"
  resource_group_name = data.azurerm_resource_group.rg.name
}

data "azurerm_key_vault_secret" "psk" {
  name         = "vwan-psk"
  key_vault_id = azurerm_key_vault.this.id #data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "storagekey" {
  name = "tfstate-access-key"
  key_vault_id = azurerm_key_vault.this.id
}



data "azurerm_storage_account" "this" {
  name                = "scvwan"
  resource_group_name = data.azurerm_resource_group.rg.name
}

output "vault_uri" {
  value = data.azurerm_key_vault.kv.vault_uri
}

data "azurerm_virtual_network" "spoke01" {
  name = "vent-networkingtest-nonprod-nocnus-001"
  #address_space       = ["10.227.0.0/22"]

  resource_group_name = data.azurerm_resource_group.networkrg.name
  provider            = azurerm.aznet

}




#resource "azurerm_virtual_hub_connection" "vwan-hub-spoke02" {
#  name                      = "vwan-hub-spoke02"
#  virtual_hub_id            = azurerm_virtual_hub.vwan-hub.id
#  remote_virtual_network_id = azurerm_virtual_network.spoke02.id
#  depends_on = [
#    azurerm_virtual_hub.vwan-hub
#  ]
#}
#
#resource "azurerm_virtual_hub_connection" "vwan-hub-spoke03" {
#  name                      = "vwan-hub-spoke03"
#  virtual_hub_id            = azurerm_virtual_hub.vwan-hub.id
#  remote_virtual_network_id = azurerm_virtual_network.spoke03.id
#  depends_on = [
#    azurerm_virtual_hub.vwan-hub,
#    azurerm_virtual_network.spoke03
#  ]
#}




#Other Examples that are helpful


