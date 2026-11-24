# 1. Asigna roles/container.hostServiceAgentUser en el Host Project para cada robot de GKE
resource "google_project_iam_member" "gke_host_service_agent" {
  for_each = var.gke_service_projects

  project = var.project_id
  role    = "roles/container.hostServiceAgentUser"
  member  = "serviceAccount:service-${each.value}@container-engine-robot.iam.gserviceaccount.com"
}

# 3. Aplana las cuentas autorizadas por cada subred
locals {
  subnet_users = flatten([
    for subnet_name, members in var.subnets_network_users : [
      for member in members : {
        key        = "${subnet_name}-${member}"
        subnetwork = subnet_name
        member     = member
      }
    ]
  ])
}

# 4. Asigna roles/compute.networkUser sobre las subredes correspondientes
resource "google_compute_subnetwork_iam_member" "network_users" {
  for_each = { for item in local.subnet_users : item.key => item }

  project    = var.project_id
  region     = var.default_region
  subnetwork = each.value.subnetwork
  role       = "roles/compute.networkUser"
  member     = each.value.member
}
