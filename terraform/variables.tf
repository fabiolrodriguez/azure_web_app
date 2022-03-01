variable "database_name" {
  default = "database-fabio-test"
  description = "The name of database"
}

variable "instance_name" {
  default = "database-fabio-test"
  description = "The name of sql server instance"
}

variable "app_name" {
  default = "web-fabio-test"
  description = "The name of application"
}

variable "location" {
  default = "East US"
  description = "Location of resources"
}

variable "storage_acc" {
  default = "examplefabiostsa"
  description = "Name of storage account"
}

variable "admin_login" {
  default = "missadministrator"
  description = "Administrator Login"
}

variable "admin_password" {
  default = "1ns3rtP4$$w0rd"
  description = "Administrator password"
}

variable "resource_group_name" {
  default = "fabio_rg"
  description = "Resource group name"
}

variable "environment" {
  default = "development"
  description = "Environment"
}

variable "subnet1" {
  default = "10.0.1.0/24"
  description = "subnet 1"
}

variable "subnet2" {
  default = "10.0.2.0/24"
  description = "subnet 2"
}

variable "sg_name" {
  default = "fabio-security-group"
  description = "name of security group"
}

variable "vnet_name" {
  default = "fabio-vnet"
  description = "name of vpc"
}

variable "db_subnet_name" {
  default = "db_subnet"
  description = "name of database subnet"
}

variable "db_subnet" {
  default = "10.0.3.0/24"
  description = "database subnet"
}

variable "bastion_subnet" {
  default = "10.0.4.0/24"
  description = "bastion subnet"
}