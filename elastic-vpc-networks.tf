# Provider
provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zones
}

resource "random_pet" "pet-prefix" {
  length = 1
  prefix = var.prefix
}

# VPC
resource "google_compute_network" "elastic-vpc" {
  name                    = "${random_pet.pet-prefix.id}-${var.network}"
  auto_create_subnetworks = "false"
}

# Elastic Subnet
resource "google_compute_subnetwork" "elastic-subnet" {
  name          = "${random_pet.pet-prefix.id}-${var.elastic_subnet}"
  region        = var.region
  network       = google_compute_network.elastic-vpc.name
  ip_cidr_range = var.elastic_subnet_cidr
  //private_ip_google_access = true
  /*  log_config {
    aggregation_interval = "INTERVAL_10_MIN"
    flow_sampling = 0.5
    metadata = "INCLUDE_ALL_METADATA"
  }*/
}

# Kibana Subnet
resource "google_compute_subnetwork" "kibana-subnet" {
  name          = "${random_pet.pet-prefix.id}-${var.kibana_subnet}"
  region        = var.region
  network       = google_compute_network.elastic-vpc.name
  ip_cidr_range = var.kibana_subnet_cidr
  //private_ip_google_access = true
  /*  log_config {
    aggregation_interval = "INTERVAL_10_MIN"
    flow_sampling = 0.5
    metadata = "INCLUDE_ALL_METADATA"
  }*/
}

