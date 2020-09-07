resource "google_compute_address" "kibana_internal_ip" { #Temp solution , revisit
  name         = "${random_pet.pet-prefix.id}-kibana-internal-ip"
  subnetwork   = google_compute_subnetwork.kibana-subnet.id
  address_type = "INTERNAL"
  region       = var.region
}

resource "google_compute_instance" "kibana_elastic_compute" {
  depends_on                = [google_compute_address.kibana_internal_ip, google_compute_forwarding_rule.elasticsearch_internal_loadbalancer]
  name                      = "${random_pet.pet-prefix.id}-kibana-compute"
  machine_type              = var.kibana_machine_type
  zone                      = var.zones
  allow_stopping_for_update = true
  tags                      = ["${random_pet.pet-prefix.id}-kibana-web"]

  boot_disk {
    initialize_params {
      image = var.kibana_gce_image
      size  = 100
      type  = "pd-ssd"
    }
  }
  network_interface {
    network    = google_compute_network.elastic-vpc.id
    subnetwork = google_compute_subnetwork.kibana-subnet.id
    network_ip = google_compute_address.kibana_internal_ip.address
  }
  service_account {
    scopes = var.machine_access_scopes
  }

  metadata_startup_script = templatefile("./kibana_yml.sh", {
    internal_lb_ip     = google_compute_forwarding_rule.elasticsearch_internal_loadbalancer.ip_address,
    kibana_server_name = "${random_pet.pet-prefix.id}-kibana-web",
    kibana_ip_address  = google_compute_address.kibana_internal_ip.address,
    kibana_port        = "5601"
  })

}

resource "google_compute_instance_group" "kibana_instance_group" {
  name      = "${random_pet.pet-prefix.id}-kibana-compute-ig"
  network   = google_compute_network.elastic-vpc.id
  instances = [google_compute_instance.kibana_elastic_compute.self_link]
  named_port {
    name = "kibana5601"
    port = 5601
  }
  zone = var.zones
}
