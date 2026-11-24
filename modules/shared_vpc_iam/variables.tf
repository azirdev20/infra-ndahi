variable "project_id" {
  description = "ID del Host Project donde viven la red y las subredes."
  type        = string
}

variable "default_region" {
  description = "Region por defecto de las subredes."
  type        = string
}

variable "gke_service_projects" {
  description = "Mapa de IDs de proyectos de servicio a sus respectivos numeros de proyecto (ej. {'ndahi-app-v1' = '483094267123'})."
  type        = map(string)
  default     = {}
}

variable "subnets_network_users" {
  description = "Mapa de subredes a la lista de miembros con permiso roles/compute.networkUser."
  type        = map(list(string))
  default     = {}
}
