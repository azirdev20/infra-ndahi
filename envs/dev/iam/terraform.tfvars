project_id     = "networking-services-ndahi"
default_region = "northamerica-south1"

service_accounts = {
  "app-backend" = {
    display_name = "Backend App Runner"
    description  = "Identidad de ejecucion para Cloud Run"
    project_roles = [
      "roles/cloudsql.client",
      "roles/secretmanager.secretAccessor"
    ]
  }
}

