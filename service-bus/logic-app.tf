#three existing logic apps

data "template_file" "workflow" {
  template = file(local.arm_file_path)
}

resource "azurerm_resource_group_template_deployment" "workflow" {
  name                = "${module.naming.logic_app_workflow.name}-${local.naming_items}"
  resource_group_name = azurerm_resource_group.this.name
  deployment_mode     = "Incremental"

  template_content = data.template_file.workflow.template

}
