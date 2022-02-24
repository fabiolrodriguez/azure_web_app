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
* Network with 2 subnets
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
state.sh
```

Then, change the block in main.if

```terraform
    backend "azurerm" {
        resource_group_name  = "tfstate"
        storage_account_name = "tfstate27890"
        container_name       = "tfstate"
        key                  = "terraform.tfstate"
    }
```
And initialize terraform

```bash
terraform init
```