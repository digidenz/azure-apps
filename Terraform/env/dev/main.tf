provider "azurerm" {
  features {}
}

module "app_weather_forecast" {
  source = "../../app_modules/weather_forecast"

  location = var.location
  env      = var.env

  apikey           = var.apikey
  docker_repo      = var.docker_repo
  docker_username  = var.docker_username
  docker_password  = var.docker_password
  docker_image     = var.docker_image
  docker_image_tag = var.docker_image_tag
}
