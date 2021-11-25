# Introduction

This project demonstrates the use of Terraform to provision Azure environments that use Azure App Services to run Linux containers.

# Folder Structure
* `Terraform/app_modules`: Modules for deploying App Services and their related resources
* `Terraform/env`: Top level Terraform projects for each environment
  * Each environment can have their own environment specific values, such as Docker image config and App Service Plan size
  * Each environment consumes the modules under `Terraform/app_modules`
* `Azure DevOps Agent`: Dockerfile used to created a Docker image for the self-hosted Azure DevOps agent which was based on the Dockerfile provided by [Microsoft](https://docs.microsoft.com/en-us/azure/devops/pipelines/agents/docker?view=azure-devops#linux). The actual Docker image can be found on [Docker Hub](https://hub.docker.com/repository/docker/digidenz/azure-devops-agent)

# CI/CD
The following [Azure DevOps release pipelines](https://dev.azure.com/digidenz/Azure%20Apps/_release) were created to automate deployments. It uses a pre-configured self-hosted Azure DevOps Agent to execute the pipelines.

* `Apps Infrastructure`: Deploy Azure environments for hosting the apps
  * Uses a pre-configured Azure Storage Account to store the Terraform state and plan
  * Uses a Service Principal with `Contributor` permission to an Azure subscription in order to deploy resources under it
  * The `Apply` stages of the pipeline require approval
* `Weather Forecast`: Deploy the latest Weather Forecast app
  * Uses Docker Image `digidenz/test`
    * This is a private repository, and is a copy of `dfranciswoolies/ciarecruitment-bestapiever`
  * Gets automatically triggered if there is a new push to the Docker image `digidenz/test
  * Use a simple shell script to check whether the `/health` endpoint returns the value `Healthy` before proceeding with the deployment

# Secret Management
Any sensitive app settings required by the apps (such as an API key, Docker repo password) are stored in an Azure Key Vault. The App Service's System Managed Identity is granted the read permission to access those secrets from the Key Vault, and the App Service's app settings also have the appropriate linkage to the Key Vault.

The secrets were injected into the Key Vault initially via the `Apps Infrastructure` release pipeline, using protected (masked) pipeline variables. 

# Environments
Below table shows the publicly accessible links to the Azure App Service hosted apps:

|                  | Dev                                                            | Prod                                                            |
| ---------------- | -------------------------------------------------------------- | --------------------------------------------------------------- |
| Weather Forecast | https://dev-weather-forecast.azurewebsites.net/weatherforecast | https://prod-weather-forecast.azurewebsites.net/weatherforecast |