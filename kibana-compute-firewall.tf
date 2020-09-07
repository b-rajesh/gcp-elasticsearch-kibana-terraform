#

resource "google_compute_firewall" "allow_kibana_to_elasticsearch" {
  priority   = 2005
  depends_on = [google_compute_network.elastic-vpc]
  name       = "${random_pet.pet-prefix.id}-allow-kibana-to-es"
  network    = "${random_pet.pet-prefix.id}-${var.network}"
  allow {
    protocol = "tcp"
    ports    = var.ports_to_open
  }

  source_ranges = [var.kibana_subnet_cidr]
  //source_tags = ["${random_pet.pet-prefix.id}-kibana-web"]
  target_tags = ["${random_pet.pet-prefix.id}-elastic-server"]
}

#
resource "google_compute_firewall" "allow_kibana_from_external" {
  priority   = 2006
  depends_on = [google_compute_network.elastic-vpc]
  name       = "${random_pet.pet-prefix.id}-allow-kibana-from-ext"
  network    = "${random_pet.pet-prefix.id}-${var.network}"
  allow {
    protocol = "tcp"
    ports    = ["5601","8080"]
  }
  source_ranges = ["0.0.0.0/0"]
  //destination_ranges = [var.kibana_subnet_cidr]
  target_tags   = ["${random_pet.pet-prefix.id}-kibana-web"]
}
