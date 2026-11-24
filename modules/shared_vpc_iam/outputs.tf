output "gke_host_service_agents" {
  description = "Lista de robots de GKE autorizados en el Host Project."
  value       = [for k, v in google_project_iam_member.gke_host_service_agent : v.member]
}

output "subnet_network_users" {
  description = "Lista de cuentas autorizadas para usar las subredes compartidas."
  value       = [for k, v in google_compute_subnetwork_iam_member.network_users : "${v.subnetwork} => ${v.member}"]
}
