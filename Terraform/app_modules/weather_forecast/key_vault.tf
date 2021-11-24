resource "azurerm_key_vault" "wf_kv" {
  name                = "${var.env}wfkv${random_id.randomId.hex}"
  location            = var.location
  resource_group_name = azurerm_resource_group.wf_rg.name

  sku_name  = "standard"
  tenant_id = data.azurerm_client_config.current.tenant_id
}

# Grant app service read access to key vault secrets
resource "azurerm_key_vault_access_policy" "wf_kv_policy_app_service" {
  key_vault_id = azurerm_key_vault.wf_kv.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = azurerm_app_service.wf_app_service.identity[0].principal_id

  secret_permissions = [
    "Get"
  ]
}

# Grant current principal set access to key vault secrets
resource "azurerm_key_vault_access_policy" "wf_kv_policy_current" {
  key_vault_id = azurerm_key_vault.wf_kv.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  secret_permissions = [
    "Get",
    "Set"
  ]
}

resource "azurerm_key_vault_secret" "wf_kv_secret_apikey" {
  depends_on = [azurerm_key_vault_access_policy.wf_kv_policy_current]

  name         = "apikey"
  value        = var.apikey
  key_vault_id = azurerm_key_vault.wf_kv.id

  lifecycle {
    ignore_changes = [value, version] # Ignore future changes, to cater for the APIKEY to change outside of Terraform
  }
}

resource "azurerm_key_vault_secret" "wf_kv_secret_docker_password" {
  depends_on = [azurerm_key_vault_access_policy.wf_kv_policy_current]

  name         = "docker-password"
  value        = var.docker_password
  key_vault_id = azurerm_key_vault.wf_kv.id
}