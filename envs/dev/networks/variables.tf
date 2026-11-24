variable "project_id" {
  description = "ID del proyecto de GCP (Host Project) para Networking."
  type        = string
}

variable "default_region" {
  description = "Region por defecto para los recursos de red."
  type        = string
  default     = "northamerica-south1"
}

variable "networks" {
  description = "Lista de redes VPC a crear o gestionar."
  type = list(object({
    network_name = string
  }))
}

variable "routing_mode" {
  description = "Modo de enrutamiento de la red (REGIONAL o GLOBAL)."
  type        = string
  default     = "REGIONAL"
}

variable "auto_create_subnetworks" {
  description = "Si es true, crea subredes automaticamente en cada region."
  type        = bool
  default     = false
}

variable "subnets" {
  description = "Lista de subredes a crear o gestionar."
  type = list(object({
    subnet_name                      = string
    subnet_ip                        = string
    subnet_region                    = optional(string)
    subnet_private_access            = optional(bool, false)
    subnet_private_ipv6_access       = optional(string)
    subnet_flow_logs                 = optional(bool, false)
    subnet_flow_logs_interval        = optional(string, "INTERVAL_5_SEC")
    subnet_flow_logs_sampling        = optional(string, "0.5")
    subnet_flow_logs_metadata        = optional(string, "INCLUDE_ALL_METADATA")
    subnet_flow_logs_filter          = optional(string, "true")
    subnet_flow_logs_metadata_fields = optional(list(string), [])
    description                      = optional(string)
    purpose                          = optional(string)
    role                             = optional(string)
    stack_type                       = optional(string)
    ipv6_access_type                 = optional(string)
    ip_collection                    = optional(string)
    external_ipv6_prefix             = optional(string)
    network_name                     = string
  }))
}

variable "secondary_ranges" {
  description = "Rangos secundarios asociados a cada subred para GKE (Pods y Services)."
  type = map(list(object({
    range_name              = string
    ip_cidr_range           = string
    reserved_internal_range = optional(string, null)
  })))
  default = {}
}

variable "shared_vpc_host" {
  description = "Indica si el proyecto actua como Host de Shared VPC."
  type        = bool
  default     = false
}

variable "service_projects" {
  description = "Lista de proyectos de servicio asociados a la Shared VPC."
  type        = list(string)
  default     = []
}

variable "gke_service_projects" {
  description = "Lista de IDs de proyectos de servicio que van a desplegar clusters de GKE."
  type        = list(string)
  default     = []
}
variable "subnets_network_users" {
  description = "Mapa de subredes a la lista de miembros con permiso de usar la red (roles/compute.networkUser)."
  type        = map(list(string))
  default     = {}
}
