# Azure Resources

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

First, you need to create the storage account to host terraform state, just run the script:

```
state.sh
```

Then, change the block in main.if

```
    backend "azurerm" {
        resource_group_name  = "tfstate"
        storage_account_name = "tfstate27890"
        container_name       = "tfstate"
        key                  = "terraform.tfstate"
    }
```