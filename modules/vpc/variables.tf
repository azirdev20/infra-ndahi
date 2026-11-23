## =========================================================================
## 1. VARIABLES GLOBALES Y DE ENLACE DE PROYECTOS (SHARED VPC)
## =========================================================================

variable "project_id" {
  description = "El ID del proyecto de GCP (Host Project) donde se crearan la red y las subredes."
  type        = string
}

# variable "network_name" {
#   description = "El nombre de la red VPC que se va a crear."
#   type        = string
# }

variable "shared_vpc_host" {
  type        = bool
  description = "Interruptor: true activa el modo Shared VPC Host, false lo omite por completo."
  default     = false
}

variable "service_projects" {
  type        = list(string)
  description = "Lista dinamica con los IDs de los proyectos de servicio (dev, qa, prod) a enlazar a la Shared VPC."
  default     = []
}

## =========================================================================
## 2. VARIABLES PARA CONFIGURACIÓN DE SUBREDES (SUBNETWORKS)
## =========================================================================

variable "subnets_region" {
  type        = string
  description = "Region global opcional. Si se define, todas las subredes se crearan en esta region."
  default     = null
}

variable "networks" {
  type = list(object({
    network_name = string
  }))
}

variable "subnets" {
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
  description = "Lista de objetos que definen la configuracion detallada de cada subred."
}

# variable "secondary_ranges" {
#   type        = map(list(object({ range_name = string, ip_cidr_range = optional(string), reserved_internal_range = optional(string) })))
#   description = "Rangos secundarios asociados a cada subred (esenciales para Pods y Services de GKE)."
#   default     = {}
# }

variable "secondary_ranges" {
  type = map(list(object({
    range_name              = string
    ip_cidr_range           = string
    reserved_internal_range = optional(string, null) # 👈 Atributo opcional con valor por defecto nulo
  })))
  default = {}
}



## =========================================================================
## 3. VARIABLES PARÁMETROS AVANZADOS DE LA VPC
## =========================================================================

variable "routing_mode" {
  type        = string
  default     = "GLOBAL"
  description = "Modo de enrutamiento de la red (REGIONAL o GLOBAL)."
}

variable "description" {
  type        = string
  description = "Una descripcion opcional para la red VPC."
  default     = ""
}

variable "auto_create_subnetworks" {
  type        = bool
  description = "Si es true, crea subredes automaticamente en cada region. Para redes personalizadas o Shared VPC debe ser false."
  default     = false
}

variable "delete_default_internet_gateway_routes" {
  type        = bool
  description = "Si es true, elimina las rutas por defecto hacia el internet gateway al crear la red."
  default     = false
}

variable "mtu" {
  type        = number
  description = "El MTU de la red (por defecto 1460, soporta 1500 o hasta 8896 para Jumbo frames)."
  default     = 0
}

variable "enable_ipv6_ula" {
  type        = bool
  description = "Habilita IPv6 ULA de forma permanente (no se puede deshacer)."
  default     = false
}

variable "internal_ipv6_range" {
  type        = string
  default     = null
  description = "Especifica un rango /48 de fd20::/20 opcional si se habilita ULA."
}

variable "network_firewall_policy_enforcement_order" {
  type        = string
  default     = null
  description = "Orden de evaluacion de politicas de firewall (BEFORE_CLASSIC_FIREWALL o AFTER_CLASSIC_FIREWALL)."
}

variable "network_profile" {
  type        = string
  default     = null
  description = "URL completa o parcial del perfil de red a aplicar."
}

variable "bgp_always_compare_med" {
  type        = bool
  description = "Si es true, Cloud Router usara los valores MED de los peers aunque los AS paths difieran."
  default     = false
}

variable "bgp_best_path_selection_mode" {
  type        = string
  description = "Modo de seleccion de mejor ruta BGP (STANDARD o LEGACY)."
  default     = "LEGACY"
}

variable "bgp_inter_region_cost" {
  type        = string
  description = "Costo inter-region de BGP si el modo es STANDARD (ej. DEFAULT o ADD_COST_TO_MED)."
  default     = null
}
