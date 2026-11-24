# =========================================================================
# BLOQUES MOVED: Migran los permisos previos al nuevo modulo module.shared_vpc_iam
# Garantizan 0 destrucciones y 0 recreaciones en GCP
# =========================================================================

moved {
  from = google_project_iam_member.gke_host_service_agent
  to   = module.shared_vpc_iam.google_project_iam_member.gke_host_service_agent["ndahi-app-v1"]
}

moved {
  from = google_compute_subnetwork_iam_member.google_apis_network_user
  to   = module.shared_vpc_iam.google_compute_subnetwork_iam_member.network_users["ndahi-gke-nodos-serviceAccount:483094267123@cloudservices.gserviceaccount.com"]
}

moved {
  from = google_compute_subnetwork_iam_member.gke_subnet_network_user
  to   = module.shared_vpc_iam.google_compute_subnetwork_iam_member.network_users["ndahi-gke-nodos-serviceAccount:service-483094267123@container-engine-robot.iam.gserviceaccount.com"]
}
