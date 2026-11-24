variable "project_id" {
  description = "ID del proyecto de GCP donde se crearan las Service Accounts."
  type        = string
}

variable "prefix" {
  description = "Prefijo opcional que se antepone a los nombres de las cuentas (ej. 'sa-')."
  type        = string
  default     = ""
}

variable "service_accounts" {
  description = "Mapa de Service Accounts a crear con sus roles asociados."
  type = map(object({
    display_name  = optional(string)
    description   = optional(string)
    disabled      = optional(bool, false)
    project_roles = optional(list(string), []) # Roles a nivel del proyecto principal
  }))
  default = {}
}
