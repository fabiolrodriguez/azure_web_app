output "hostname" {
  value       = azurerm_app_service.webapp.default_site_hostname
  description = "The default hostname of the web app."
}

output "publish_profile" {
  value = azurerm_app_service.webapp.site_credential
  description = "The credentials of webapp"
}