#

resource "google_compute_firewall" "allow_kibana_to_elasticsearch" {
  depends_on = [google_compute_network.elastic-vpc]
  name       = "${random_pet.pet-prefix.id}-allow-kibana-to-es"
  network    = "${random_pet.pet-prefix.id}-${var.network}"
  allow {
    protocol = "tcp"
    ports    = var.ports_to_open
  }
  
  source_ranges        = [var.kibana_subnet_cidr]
  target_tags = ["${random_pet.pet-prefix.id}-elastic-server"]
}

#
resource "google_compute_firewall" "allow_kibana_from_external" {
  depends_on = [google_compute_network.elastic-vpc]
  name       = "${random_pet.pet-prefix.id}-allow-kibana-from-ext"
  network    = "${random_pet.pet-prefix.id}-${var.network}"
  allow {
    protocol = "tcp"
    ports    = ["8080",]
  }
  source_ranges         = ["0.0.0.0/0"]
  target_tags           = ["${random_pet.pet-prefix.id}-kibana-web"]
}