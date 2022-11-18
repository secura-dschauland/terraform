
resource "azurerm_storage_account" "this" {
  name                = "${module.naming.storage_account.name}swagger"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location

  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "this" {
  name                  = "swagger"
  storage_account_name  = azurerm_storage_account.this.name
  container_access_type = "blob"
}

resource "azurerm_storage_blob" "this" {
  name                   = "swagger.json"
  storage_account_name   = azurerm_storage_account.this.name
  storage_container_name = azurerm_storage_container.this.name
  type                   = "Block"

  source = "swagger.json"

}

#use this for swagger fetching - read terraform docs about provisioners for more info
resource "null_resource" "fileupload" {
  provisioner "local-exec" {

    command = <<EOT
    $jsonFile = invoke-webrequest -uri https://entapi-dev.intranet.secura.net/XapiDuckCreek/swagger/v1/swagger.json -outfile swagger.json

    EOT
    interpreter = [
      "PowerShell", "-Command"
    ]
  }
}

output "sasURI" {
  value = azurerm_storage_blob.this.url
}
