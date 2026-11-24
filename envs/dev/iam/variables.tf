variable "project_id" {
  description = "ID del proyecto de GCP (Host Project) para Networking."
  type        = string
}

variable "default_region" {
  description = "Region por defecto para los recursos de red."
  type        = string
  default     = "northamerica-south1"
}

variable "service_accounts" {
  description = "Mapa de Service Accounts para este entorno."
  type        = any
  default     = {}
}
