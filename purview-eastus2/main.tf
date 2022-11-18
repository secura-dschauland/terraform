locals {
  location = var.location

  req_tags = {
    solution   = var.req_tags.solution_tag
    department = var.req_tags.department_tag
    owner      = var.req_tags.owner_tag
  }

  environment_tags = var.env_specific_tags

  tags = merge(var.env_specific_tags, local.req_tags)
}

module "naming" {
  source  = "Azure/naming/azurerm"
  version = "0.2.0"
}

resource "azurerm_resource_group" "res-0" {
  location = local.location                                                                                                            #"eastus2"
  name     = "${module.naming.resource_group.name}-${local.req_tags.solution}-${local.environment_tags.environment}-${local.location}" #"rg-iap-prod-eastus2"
  tags     = local.tags
}
