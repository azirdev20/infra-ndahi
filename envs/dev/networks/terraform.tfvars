project_id     = "networking-services-ndahi"
default_region = "northamerica-south1"

networks = [
  {
    network_name = "ndahi-vpc"
  }
]

routing_mode            = "REGIONAL"
auto_create_subnetworks = false

subnets = [
  {
    subnet_name           = "ndahi-gke-nodos"
    subnet_ip             = "10.10.0.0/28"
    subnet_region         = "northamerica-south1"
    subnet_private_access = true
    subnet_flow_logs      = false
    network_name          = "ndahi-vpc"
  }
]

secondary_ranges = {
  "ndahi-gke-nodos" = [
    {
      range_name    = "ndahi-gke-pods"
      ip_cidr_range = "10.11.0.0/22"
    },
    {
      range_name    = "ndahi-gke-services"
      ip_cidr_range = "10.11.4.0/24"
    }
  ]
}

shared_vpc_host  = true
service_projects = ["ndahi-app-v1"]

gke_service_projects = {
  "ndahi-app-v1" = "483094267123"
}

subnets_network_users = {
  "ndahi-gke-nodos" = [
    "serviceAccount:483094267123@cloudservices.gserviceaccount.com",
    "serviceAccount:service-483094267123@container-engine-robot.iam.gserviceaccount.com"
  ]
}
