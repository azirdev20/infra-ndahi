module "vpc" {
  source = "../../../modules/vpc"

  project_id              = var.project_id
  networks                = var.networks
  routing_mode            = var.routing_mode
  auto_create_subnetworks = var.auto_create_subnetworks
  subnets                 = var.subnets
  secondary_ranges        = var.secondary_ranges
  shared_vpc_host         = var.shared_vpc_host
  service_projects        = var.service_projects
}

module "shared_vpc_iam" {
  source = "../../../modules/shared_vpc_iam"

  project_id            = var.project_id
  default_region        = var.default_region
  gke_service_projects  = var.gke_service_projects
  subnets_network_users = var.subnets_network_users
}
