module "vpc" {
  source = "../../modules/vpc"

  project_id              = var.project_id
  networks                = var.networks
  routing_mode            = var.routing_mode
  auto_create_subnetworks = var.auto_create_subnetworks
  subnets                 = var.subnets
  secondary_ranges        = var.secondary_ranges
  shared_vpc_host         = var.shared_vpc_host
  service_projects        = var.service_projects
}

# =========================================================================
# BLOQUES DE IMPORTACIÓN (Terraform 1.5+)
# Permiten importar la infraestructura existente en GCP al estado de Terraform
# =========================================================================

# 1. Importar la VPC existente
import {
  to = module.vpc.google_compute_network.network["ndahi-vpc"]
  id = "projects/networking-services-ndahi/global/networks/ndahi-vpc"
}

# 2. Importar la Subnet existente (con sus rangos secundarios)
import {
  to = module.vpc.google_compute_subnetwork.subnetwork["northamerica-south1/ndahi-gke-nodos"]
  id = "projects/networking-services-ndahi/regions/northamerica-south1/subnetworks/ndahi-gke-nodos"
}

# 3. Importar el Host de la Shared VPC
import {
  to = module.vpc.google_compute_shared_vpc_host_project.shared_vpc_host[0]
  id = "networking-services-ndahi"
}

# 4. Importar el Service Project enlazado
import {
  to = module.vpc.google_compute_shared_vpc_service_project.service_projects["ndahi-app-v1"]
  id = "networking-services-ndahi/ndahi-app-v1"
}
