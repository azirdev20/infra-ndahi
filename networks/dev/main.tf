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
