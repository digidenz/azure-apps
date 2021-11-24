data "azurerm_client_config" "current" {}

# Use for resources that require a globally unique name
resource "random_id" "randomId" {
  keepers = {
    resource_group = azurerm_resource_group.wf_rg.name
  }
  byte_length = 4
}
