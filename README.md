# Introduction

This project demonstrates the use of Terraform to provision an Azure environment for hosting App Services using Linux containers.

# Folder Structure
* `Terraform/app_modules`: Modules for deploying various apps and their related resources
* `Terraform/env`: Top level Terraform project for each environment
* `Azure DevOps Agent`: Dockerfile used to created a Docker image for the self-hosted Azure DevOps agent

# CI/CD
The following Azure DevOps release pipelines are used to automate deployments.

* `Apps Infrastructure`: Deploy Azure environments for hosting the apps
* `Weather Forecast`: Deploy the Weather Forecast app

# Environments
|                  | Dev                                            |
| ---------------- | ---------------------------------------------- |
| Weather Forecast | https://dev-weather-forecast.azurewebsites.net |