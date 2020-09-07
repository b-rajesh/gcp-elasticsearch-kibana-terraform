#Add some labels to it..
resource "google_compute_forwarding_rule" "elasticsearch_internal_loadbalancer" {
  name                  = "${random_pet.pet-prefix.id}-es-internal-lb"
  load_balancing_scheme = "INTERNAL"
  ports                 = var.ports_to_open
  network               = google_compute_network.elastic-vpc.id
  subnetwork            = google_compute_subnetwork.elastic-subnet.id
  backend_service       = google_compute_region_backend_service.elastictsearch_region_backend_service.self_link
}

resource "google_compute_region_backend_service" "elastictsearch_region_backend_service" {
  name                  = "${random_pet.pet-prefix.id}-es-backend-service"
  load_balancing_scheme = "INTERNAL"
  health_checks         = [google_compute_health_check.lb_elasticsearch_health_check.id]
  region                = var.region
  session_affinity                = "CLIENT_IP"
  backend {
    group = google_compute_instance_group.primary-elastic-compute-instance-group.self_link
  }
  backend {
    group = google_compute_instance_group.secondary-elastic-compute-instance-group.self_link
  }
}

resource "google_compute_health_check" "lb_elasticsearch_health_check" {
  name               = "${random_pet.pet-prefix.id}-lb-elasticsearch-health-check"
  check_interval_sec = 300
  timeout_sec        = 300
  /*
  http_health_check {
    host               = google_compute_address.elastic_instance_private_ips[0].address
    proxy_header       = "NONE"
    port               = "9200"
    request_path       = "/"
  }
*/
  tcp_health_check {
    port         = "9200"
    //proxy_header = "NONE"
    //response     = "name"
  }
}