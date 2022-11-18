# configure backend 
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0.0"
    }
  }
}

# configure provider(s)
provider "azurerm" {
  features {}

  subscription_id = var.subscription_id
}

# collect naming module items
module "naming" {
  source  = "Azure/naming/azurerm"
  version = "0.2.0"
}

# configure locals for this project - 
# I use locals alot to allow one stop variable updates - resources then get locals
locals {
  location = var.location

  req_tags = {
    solution    = var.req_tags.solution_tag
    department  = var.req_tags.department_tag
    owner       = var.req_tags.owner_tag
    environment = var.req_tags.environment_tag
  }

  naming_items = trim(lower("${local.req_tags.environment}-${local.req_tags.department}-${local.req_tags.solution}"), " ")

  sb_sku        = var.sb_sku
  capacity      = var.capacity
  arm_file_path = "template.json"
}

# create resource group
resource "azurerm_resource_group" "this" {
  name     = "${module.naming.resource_group.name}-${local.naming_items}"
  location = local.location

  tags = local.req_tags
}
