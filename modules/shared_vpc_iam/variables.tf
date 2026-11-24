variable "project_id" {
  description = "ID del Host Project donde viven la red y las subredes."
  type        = string
}

variable "default_region" {
  description = "Region por defecto de las subredes."
  type        = string
}

variable "gke_service_projects" {
  description = "Lista de IDs de proyectos de servicio que ejecutaran clusters de GKE."
  type        = list(string)
  default     = []
}

variable "subnets_network_users" {
  description = "Mapa de subredes a la lista de miembros con permiso roles/compute.networkUser."
  type        = map(list(string))
  default     = {}
}
