resource "azurerm_resource_group" "wf_rg" {
  name     = "${var.env}_wf_rg"
  location = var.location
}
