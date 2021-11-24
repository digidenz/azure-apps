# Introduction

This project demonstrates the use of Terraform to provision an Azure environment that uses Azure App Services to run Linux containers.

# Folder Structure
* `Terraform/app_modules`: Modules for deploying various apps and their related resources
* `Terraform/env`: Top level Terraform project for each environment
* `Azure DevOps Agent`: Dockerfile used to created a Docker image for the self-hosted Azure DevOps agent which was based on the Dockerfile provided by [Microsoft](https://docs.microsoft.com/en-us/azure/devops/pipelines/agents/docker?view=azure-devops#linux). The actual Docker image can be found on [Docker Hub](https://hub.docker.com/repository/docker/digidenz/azure-devops-agent)

# CI/CD
The following [Azure DevOps release pipelines](https://dev.azure.com/digidenz/Azure%20Apps/_release) were created to automate deployments.

* `Apps Infrastructure`: Deploy Azure environments for hosting the apps
* `Weather Forecast`: Deploy the latest Weather Forecast app
  * Docker Image: `digidenz/test`, private repository, and is a copy of `dfranciswoolies/ciarecruitment-bestapiever`

An app deployment pipeline (such as `Weather Forecast`) gets automatically triggered if there is a new push to the Docker image associated with that pipeline. It will check whether the `/health` endpoint returns the value `Healthy` before the actual deployment.

# Environments
Below table shows the publicly accessible links to the Azure App Service hosted apps:

|                  | Dev                                            |
| ---------------- | ---------------------------------------------- |
| Weather Forecast | https://dev-weather-forecast.azurewebsites.net |