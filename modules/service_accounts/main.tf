locals {
  # Agrega un guion al prefijo si existe (ej. "sa" -> "sa-")
  prefix = var.prefix != "" ? "${var.prefix}-" : ""

  # Aplana la relacion (Cuenta <-> Rol) en una lista simple para el for_each
  sa_roles = flatten([
    for sa_key, sa in var.service_accounts : [
      for role in coalesce(sa.project_roles, []) : {
        key    = "${sa_key}-${role}"
        sa_key = sa_key
        role   = role
      }
    ]
  ])
}

# 1. Crear las Service Accounts
resource "google_service_account" "accounts" {
  for_each     = var.service_accounts
  account_id   = "${local.prefix}${lower(each.key)}"
  display_name = coalesce(each.value.display_name, each.key)
  description  = each.value.description
  project      = var.project_id
  disabled     = each.value.disabled
}

# 2. Asignar los roles correspondientes a cada cuenta
resource "google_project_iam_member" "project_roles" {
  for_each = { for item in local.sa_roles : item.key => item }

  project = var.project_id
  role    = each.value.role
  member  = "serviceAccount:${google_service_account.accounts[each.value.sa_key].email}"
}
