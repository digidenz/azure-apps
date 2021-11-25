# Environment
variable "location" {
  description = "The location of the environment."
}
variable "env" {
  description = "The name of the environment."
}

# App
variable "apikey" {
  description = "The api key for the app"
}
variable "docker_repo" {
  description = "The URL to the Docker repo"
}
variable "docker_username" {
  description = "The username to access the Docker repo"
}
variable "docker_password" {
  description = "The password to access the Docker repo"
}
variable "docker_image" {
  description = "The name of docker image to deploy"
}
variable "docker_image_tag" {
  description = "The tag of docker image to deploy"
}
variable "asp_sku" {
  description = "The SKU for the App Service Plan"
  type = object({
    tier = string
    size = string
  })
}