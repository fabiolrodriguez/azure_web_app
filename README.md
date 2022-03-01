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
