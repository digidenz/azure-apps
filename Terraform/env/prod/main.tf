provider "azurerm" {
  features {}
}

module "app_weather_forecast" {
  source = "../../app_modules/weather_forecast"

  location = var.location
  env      = var.env

  apikey           = var.wf_apikey
  docker_repo      = var.wf_docker_repo
  docker_username  = var.wf_docker_username
  docker_password  = var.wf_docker_password
  docker_image     = var.wf_docker_image
  docker_image_tag = var.wf_docker_image_tag
  asp_sku          = var.wf_asp_sku
}

# Additional apps from other modules can also be defined here