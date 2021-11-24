resource "azurerm_app_service_plan" "wf_app_service_plan" {
  name                = "${var.env}_wf_app_service_plan"
  location            = var.location
  resource_group_name = azurerm_resource_group.wf_rg.name

  kind     = "Linux"
  reserved = true

  sku {
    tier = "Free"
    size = "F1"
  }
}

resource "azurerm_app_service" "wf_app_service" {
  name                = "${var.env}-weather-forecast"
  location            = var.location
  resource_group_name = azurerm_resource_group.wf_rg.name
  app_service_plan_id = azurerm_app_service_plan.wf_app_service_plan.id

  identity {
    type = "SystemAssigned"
  }

  site_config {
    linux_fx_version          = "DOCKER|${var.docker_image}:${var.docker_image_tag}"
    use_32_bit_worker_process = true
  }

  app_settings = {
    "APIKEY"                          = "@Microsoft.KeyVault(SecretUri=${azurerm_key_vault_secret.wf_kv_secret_apikey.versionless_id})"
    "DOCKER_REGISTRY_SERVER_URL"      = var.docker_repo
    "DOCKER_REGISTRY_SERVER_USERNAME" = var.docker_username
    "DOCKER_REGISTRY_SERVER_PASSWORD" = "@Microsoft.KeyVault(SecretUri=${azurerm_key_vault_secret.wf_kv_secret_docker_password.versionless_id})"
  }

  lifecycle {
    ignore_changes = [
      site_config[0].linux_fx_version # Deployment of app is managed by Azure DevOps
    ]
  }
}