variable "database_name" {
  default = "database-fabio-test"
  description = "The name of database"
}

variable "location" {
  default = "East US"
  description = "Location of database"
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
  default = "INSERT YOUR PASSWORD"
  description = "Administrator password"
}
