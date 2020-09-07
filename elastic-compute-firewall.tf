resource "google_compute_firewall" "allow_inbound_ssh" {
  depends_on = [google_compute_network.elastic-vpc]
  name       = "${random_pet.pet-prefix.id}-allow-ssh-access"
  network    = "${random_pet.pet-prefix.id}-${var.network}"
  priority   = 2000
  allow {
    protocol = "tcp"

    ports = [
      22,
    ]
  }
  
  source_ranges = var.allowed_inbound_cidr_blocks_ssh
  target_tags   = ["${random_pet.pet-prefix.id}-elastic-server", "${random_pet.pet-prefix.id}-kibana-web"]
}
/*
resource "google_compute_firewall" "allow-all-internal" {
  depends_on = [google_compute_network.elastic-vpc]
  name       = "${random_pet.pet-prefix.id}-allow-all-internal"
  network    = "${random_pet.pet-prefix.id}-${var.network}"
  priority   = 2001
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
*/
resource "google_compute_firewall" "allow-internal-lb" {
  priority   = 2003
  depends_on = [google_compute_network.elastic-vpc]
  name       = "${random_pet.pet-prefix.id}-allow-internal-lb"
  network    = "${random_pet.pet-prefix.id}-${var.network}"
  allow {
    protocol = "tcp"
    ports    = var.ports_to_open
  }
    allow {
    protocol = "udp"
    ports    = var.ports_to_open
  }
    allow {
    protocol = "icmp"
  }
  //source_ranges = [var.elastic_subnet_cidr, var.kibana_subnet_cidr] // Subnet where kibana-web, ElasticSearch and your Internal Load balancer is going to run
  source_ranges = [var.elastic_subnet_cidr, "130.211.0.0/22", "35.191.0.0/16"] // Subnet where kibana-web, ElasticSearch and your Internal Load balancer is going to run
  target_tags   = ["${random_pet.pet-prefix.id}-elastic-server"]
}

resource "google_compute_firewall" "allow-health-check" {
  priority   = 2004
  depends_on = [google_compute_network.elastic-vpc]
  name       = "${random_pet.pet-prefix.id}-allow-health-check"
  network    = "${random_pet.pet-prefix.id}-${var.network}"
  allow {
    protocol = "tcp"
    ports    = var.ports_to_open
  }
  source_ranges = ["130.211.0.0/22", "35.191.0.0/16"] // Subnet where ElasticSearch and your Load balancer is going to run
  target_tags   = ["${random_pet.pet-prefix.id}-elastic-server"]
}

