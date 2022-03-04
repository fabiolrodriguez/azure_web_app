resource "azurerm_mssql_server" "sqlserver" {
  name                         = var.instance_name
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = azurerm_resource_group.rg.location
  version                      = "12.0"
  administrator_login          = var.admin_login
  administrator_login_password = var.admin_password 
  minimum_tls_version          = "1.2"

  tags = {
    environment = "development"
  }
}

resource "azurerm_mssql_database" "base" {
  name           = var.database_name
  server_id      = azurerm_mssql_server.sqlserver.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  read_scale     = false
  sku_name       = "S0"
  zone_redundant = false
}

resource "azurerm_mssql_database_extended_auditing_policy" "example" {
  database_id                             = azurerm_mssql_database.base.id
  storage_endpoint                        = azurerm_storage_account.sacc.primary_blob_endpoint
  storage_account_access_key              = azurerm_storage_account.sacc.primary_access_key
  storage_account_access_key_is_secondary = false
  retention_in_days                       = 6
}

resource "azurerm_sql_firewall_rule" "app_server_firewall_rule" {
  for_each = toset(azurerm_app_service.webapp.outbound_ip_address_list)

  name                = "web_app_ip_${replace(each.value, ".", "_")}"
  resource_group_name = azurerm_resource_group.rg.name
  server_name         = azurerm_mssql_server.sqlserver.name
  start_ip_address    = each.value
  end_ip_address      = each.value
}