resource "google_compute_firewall" "allow_inbound_ssh" {
  depends_on = [google_compute_network.elastic-vpc]
  name       = "${random_pet.pet-prefix.id}-allow-ssh-access"
  network    = "${random_pet.pet-prefix.id}-${var.network}"
  allow {
    protocol = "tcp"

    ports = [
      22,
    ]
  }

  source_ranges = var.allowed_inbound_cidr_blocks_ssh
  target_tags   = ["${random_pet.pet-prefix.id}-elastic-server"]
}

resource "google_compute_firewall" "allow-all-internal" {
  depends_on = [google_compute_network.elastic-vpc]
  name       = "${random_pet.pet-prefix.id}-allow-all-internal"
  network    = "${random_pet.pet-prefix.id}-${var.network}"
  allow {
    protocol = "tcp"
  }
  allow {
    protocol = "udp"
  }
  allow {
    protocol = "icmp"
  }
  source_ranges = [var.elastic_subnet_cidr] // your subnet IP range
}

resource "google_compute_firewall" "allow-internal-lb" {
  depends_on = [google_compute_network.elastic-vpc]
  name       = "${random_pet.pet-prefix.id}-allow-internal-lb"
  network    = "${random_pet.pet-prefix.id}-${var.network}"
  allow {
    protocol = "tcp"
    ports    = var.ports_to_open
  }
  source_ranges = [var.elastic_subnet_cidr] // Subnet where ElasticSearch and your Load balancer is going to run
  target_tags   = ["${random_pet.pet-prefix.id}-elastic-server"]
}

resource "google_compute_firewall" "allow-health-check" {
  depends_on = [google_compute_network.elastic-vpc]
  name       = "${random_pet.pet-prefix.id}-allow-health-check"
  network    = "${random_pet.pet-prefix.id}-${var.network}"
  allow {
    protocol = "tcp"
    ports    = var.ports_to_open
  }
  source_ranges = [var.elastic_subnet_cidr] // Subnet where ElasticSearch and your Load balancer is going to run
  target_tags   = ["${random_pet.pet-prefix.id}-elastic-server"]
}

