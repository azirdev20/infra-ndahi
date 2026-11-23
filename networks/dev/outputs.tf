output "network_name" {
  value       = module.vpc.network_name
  description = "Nombre de la red VPC."
}

output "network_id" {
  value       = module.vpc.network_id
  description = "ID completo de la red VPC."
}

output "network_self_link" {
  value       = module.vpc.network_self_link
  description = "URI self_link de la red VPC."
}

output "subnets" {
  value       = module.vpc.subnets
  description = "Mapa de subredes indexadas por region/nombre."
}

output "subnets_ids" {
  value       = module.vpc.subnets_ids
  description = "Mapa con los IDs de todas las subredes creadas."
}

output "subnets_ips" {
  value       = module.vpc.subnets_ips
  description = "Mapa con los segmentos CIDR primarios de cada subred."
}

output "shared_vpc_enabled" {
  value       = module.vpc.shared_vpc_enabled
  description = "Indica si el proyecto es Host de Shared VPC."
}
