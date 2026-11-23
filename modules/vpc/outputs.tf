# modules/networking/outputs.tf

output "network_name" {
  value       = try(values(google_compute_network.network)[0].name, null)
  description = "El nombre de la red VPC creada."
}

output "network_id" {
  value       = try(values(google_compute_network.network)[0].id, null)
  description = "El ID de la red VPC creada."
}

output "network_self_link" {
  value       = try(values(google_compute_network.network)[0].self_link, null)
  description = "El URI de la red VPC creada (util para configuraciones de interconexiones)."
}

output "networks" {
  value       = google_compute_network.network
  description = "Mapa completo de todas las redes VPC creadas indexadas por nombre."
}

output "subnets" {
  value       = { for k, v in google_compute_subnetwork.subnetwork : k => v.name }
  description = "Un mapa de todas las subredes creadas indexadas por la combinacion 'region/nombre'."
}

output "subnets_ids" {
  value       = { for k, v in google_compute_subnetwork.subnetwork : k => v.id }
  description = "Un mapa con los IDs completos de GCP de todas las subredes creadas."
}

output "subnets_ips" {
  value       = { for k, v in google_compute_subnetwork.subnetwork : k => v.ip_cidr_range }
  description = "Un mapa con los segmentos CIDR primarios de cada subred creada."
}

output "shared_vpc_enabled" {
  value       = var.shared_vpc_host && length(google_compute_shared_vpc_host_project.shared_vpc_host) > 0
  description = "Retorna true si el proyecto fue habilitado exitosamente como Host de VPC Compartida."
}
