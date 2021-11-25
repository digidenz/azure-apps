# Environment
variable "location" {
  description = "The location of the environment."
}
variable "env" {
  description = "The name of the environment."
}

# App - Weather Forecast (wf)
variable "wf_apikey" {
  description = "The api key for the app"
}
variable "wf_docker_repo" {
  description = "The URL to the Docker repo"
}
variable "wf_docker_username" {
  description = "The username to access the Docker repo"
}
variable "wf_docker_password" {
  description = "The password to access the Docker repo"
}
variable "wf_docker_image" {
  description = "The name of docker image to deploy"
}
variable "wf_docker_image_tag" {
  description = "The tag of docker image to deploy"
}
variable "wf_asp_sku" {
  description = "The SKU for the App Service Plan"
  type = object({
    tier = string
    size = string
  })
}