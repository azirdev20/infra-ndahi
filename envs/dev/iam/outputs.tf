output "emails" {
  description = "Mapa con los correos electronicos de todas las Service Accounts creadas."
  value       = module.service_accounts.emails
}

output "iam_emails" {
  description = "Mapa con las identidades IAM listas para asignar permisos (serviceAccount:correo)."
  value       = module.service_accounts.iam_emails
}

output "service_accounts" {
  description = "Mapa completo de los objetos de Service Account creados."
  value       = module.service_accounts.service_accounts
}
