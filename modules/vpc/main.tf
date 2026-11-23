/******************************************
	VPC configuration
 *****************************************/


resource "google_compute_network" "network" {
  for_each                                  = { for net in var.networks : net.network_name => net }
  name                                      = each.value.network_name
  auto_create_subnetworks                   = var.auto_create_subnetworks
  routing_mode                              = var.routing_mode
  project                                   = var.project_id
  description                               = var.description
  delete_default_routes_on_create           = var.delete_default_internet_gateway_routes
  mtu                                       = var.mtu
  enable_ula_internal_ipv6                  = var.enable_ipv6_ula
  internal_ipv6_range                       = var.internal_ipv6_range
  network_firewall_policy_enforcement_order = var.network_firewall_policy_enforcement_order
  network_profile                           = var.network_profile

  # BGP best path selection mode - always set
  bgp_best_path_selection_mode = var.bgp_best_path_selection_mode

  # BGP MED and inter-region cost - only valid with STANDARD mode
  # GCP API rejects these fields when mode is LEGACY, even if set to false/null
  bgp_always_compare_med = var.bgp_best_path_selection_mode == "STANDARD" ? var.bgp_always_compare_med : null
  bgp_inter_region_cost  = var.bgp_best_path_selection_mode == "STANDARD" ? var.bgp_inter_region_cost : null
}


/******************************************
	Shared VPC
 *****************************************/
resource "google_compute_shared_vpc_host_project" "shared_vpc_host" {

  count      = var.shared_vpc_host ? 1 : 0
  project    = var.project_id
  depends_on = [google_compute_network.network]
}

resource "google_compute_shared_vpc_service_project" "service_projects" {
  # Si 'shared_vpc_host' es true, itera sobre la lista. Si es false, crea una lista vacía e ignora este bloque.
  for_each = toset(var.shared_vpc_host ? var.service_projects : [])

  host_project    = var.project_id
  service_project = each.value

  depends_on = [google_compute_shared_vpc_host_project.shared_vpc_host]
}



locals {
  subnets = {
    for x in var.subnets :
    "${coalesce(var.subnets_region, x.subnet_region, "undefined")}/${x.subnet_name}" => x
  }
}


/******************************************
	Subnet configuration
 *****************************************/
resource "google_compute_subnetwork" "subnetwork" {

  for_each                   = local.subnets
  name                       = each.value.subnet_name
  ip_cidr_range              = each.value.subnet_ip
  region                     = var.subnets_region != null ? var.subnets_region : each.value.subnet_region
  private_ip_google_access   = lookup(each.value, "subnet_private_access", false)
  private_ipv6_google_access = lookup(each.value, "subnet_private_ipv6_access", null)
  dynamic "log_config" {
    for_each = coalesce(lookup(each.value, "subnet_flow_logs", null), false) ? [{
      aggregation_interval = each.value.subnet_flow_logs_interval
      flow_sampling        = each.value.subnet_flow_logs_sampling
      metadata             = each.value.subnet_flow_logs_metadata
      filter_expr          = each.value.subnet_flow_logs_filter
      metadata_fields      = each.value.subnet_flow_logs_metadata_fields
    }] : []
    content {
      aggregation_interval = log_config.value.aggregation_interval
      flow_sampling        = log_config.value.flow_sampling
      metadata             = log_config.value.metadata
      filter_expr          = log_config.value.filter_expr
      metadata_fields      = log_config.value.metadata == "CUSTOM_METADATA" ? log_config.value.metadata_fields : null
    }
  }
  network     = google_compute_network.network[each.value.network_name].id
  project     = var.project_id
  description = lookup(each.value, "description", null)
  # dynamic "secondary_ip_range" {





  #   for_each = contains(keys(var.secondary_ranges), each.value.subnet_name) == true ? var.secondary_ranges[each.value.subnet_name] : []

  #   content {
  #     range_name              = secondary_ip_range.value.range_name
  #     ip_cidr_range           = secondary_ip_range.value.ip_cidr_range
  #     reserved_internal_range = secondary_ip_range.value.reserved_internal_range
  #   }
  # }


  dynamic "secondary_ip_range" {
    # 💡 lookup() busca el subnet_name en el mapa; si no existe, devuelve una lista vacía []
    for_each = lookup(var.secondary_ranges, each.value.subnet_name, [])

    content {
      range_name    = secondary_ip_range.value.range_name
      ip_cidr_range = secondary_ip_range.value.ip_cidr_range

      # 💡 Usamos lookup también aquí por si acaso no definiste 'reserved_internal_range' en todos tus entornos
      reserved_internal_range = lookup(secondary_ip_range.value, "reserved_internal_range", null)
    }
  }


  purpose              = lookup(each.value, "purpose", null)
  role                 = lookup(each.value, "role", null)
  stack_type           = lookup(each.value, "stack_type", null)
  ipv6_access_type     = lookup(each.value, "ipv6_access_type", null)
  ip_collection        = lookup(each.value, "ip_collection", null)
  external_ipv6_prefix = lookup(each.value, "external_ipv6_prefix", null)

  lifecycle {
    precondition {
      condition     = var.subnets_region != null || each.value.subnet_region != null
      error_message = "A region must be provided either via 'subnets_region' or 'subnet_region' in the subnet definition."
    }
  }
}


