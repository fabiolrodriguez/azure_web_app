# Azure Resources

## Pre reqs

* Terraform v1.1+
* Azure cli
* Azure free tier account

## Architecture

These scripts will brigh up the services:

* Resource Group
* Service Plan
* Storage Account
* Mssql Instance
* SQL Database
* Web app

## Usage

### Azure login

Just login in your Azure cli.

```
az login
```

### Setup Backend

Now, you need to create the storage account to host terraform state, just run the script:

```bash
cd terraform
./state.sh
```

Then, change the block in main.if including your generated storage account

```terraform
    backend "azurerm" {
        resource_group_name  = "tfstate"
        storage_account_name = "tfstateXXXXX"
        container_name       = "tfstate"
        key                  = "terraform.tfstate"
    }
```
And initialize terraform

```bash
terraform init
```
### Creating Infrastructure

Run the plan:

```bash
terraform plan
```

Analyse the plan and, if everything is OK, create the stuff:

```bash
terraform apply
```

## Configuring Application

On webapp.tf, there is a block of code referencing the github repository of a sample Node.js application:

```terraform
  source_control {
    repo_url           = "https://github.com/fabiolrodriguez/nodejs-docs-hello-world"
    branch             = "master"
    manual_integration = true
    use_mercurial      = false
  }
```

When you create the Azure WebApp, these app will be deployed on it. Just fork this repo (or change to your on repository).

You will need the following file /*.github/workflows/workflow.yml*/ on your application repository.

```yaml
name: Deploy Node.js to Azure Web App

on:
  [push]

# CONFIGURATION
# For help, go to https://github.com/Azure/Actions
#
# 1. Set up the following secrets in your repository:
#   AZURE_WEBAPP_PUBLISH_PROFILE
#
# 2. Change these variables for your configuration:
env:
  AZURE_WEBAPP_NAME: webapp-34549     # set this to your application's name
  AZURE_WEBAPP_PACKAGE_PATH: '.'      # set this to the path to your web app project, defaults to the repository root
  NODE_VERSION: '14.x'                # set this to the node version to use
  DB_URL: ${{ secrets.DB_URL }}
  DB_USER: ${{ secrets.DB_USER }}
  DB_PASS: ${{ secrets.DB_PASS }}
  DB_NAME: ${{ secrets.DB_NAME }}

jobs:
  build-and-deploy:
    name: Build and Deploy
    runs-on: ubuntu-latest
    environment: dev
    steps:
    - uses: actions/checkout@master
    - name: Use Node.js ${{ env.NODE_VERSION }}
      uses: actions/setup-node@v1
      with:
        node-version: ${{ env.NODE_VERSION }}
    - name: npm install, build, and test
      run: |
        # Build and test the project, then
        # deploy to Azure Web App.
        npm install
        npm run build --if-present
        npm run test --if-present
    - name: 'Deploy to Azure WebApp'
      uses: azure/webapps-deploy@v2
      with: 
        app-name: ${{ env.AZURE_WEBAPP_NAME }}
        publish-profile: ${{ secrets.AZURE_WEBAPP_PUBLISH_PROFILE }}
        package: ${{ env.AZURE_WEBAPP_PACKAGE_PATH }}
        
  # For more information on GitHub Actions for Azure, refer to https://github.com/Azure/Actions
  # For more samples to get started with GitHub Action workflows to deploy to Azure, refer to https://github.com/Azure/actions-workflow-samples
```

### Setup CI/CD

After run /*terraform apply*/, a local archive publish.profile.xml will be generated.

To configure Github Actions, 