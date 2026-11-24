output "emails" {
  description = "Mapa con los correos electronicos de todas las Service Accounts creadas."
  value       = { for k, sa in google_service_account.accounts : k => sa.email }
}

output "iam_emails" {
  description = "Mapa con las identidades IAM listas para asignar permisos (serviceAccount:correo)."
  value       = { for k, sa in google_service_account.accounts : k => "serviceAccount:${sa.email}" }
}

output "service_accounts" {
  description = "Mapa completo de los objetos de Service Account creados."
  value       = google_service_account.accounts
}
