#Add some labels to it..
resource "google_compute_forwarding_rule" "kibana_external_loadbalancer" {
  name                  = "${random_pet.pet-prefix.id}-kibana-external-lb"
  port_range            = "8080"
  target                = google_compute_target_pool.kibana_instance_target_pool.self_link
  load_balancing_scheme = "EXTERNAL"
}

resource "google_compute_target_pool" "kibana_instance_target_pool" {
  name = "${random_pet.pet-prefix.id}-kibana-instance-tg"
  instances        = [google_compute_instance.kibana_elastic_compute.self_link]
  //session_affinity = var.session_affinity
  //health_checks = [google_compute_health_check.lb_kibana_health_check.self_link]
}
/*

resource "google_compute_health_check" "lb_kibana_health_check" {
  name               = "${random_pet.pet-prefix.id}-lb-kibana-health-check"
  http_health_check {
    port         = "8080"
    proxy_header = "NONE"
  }
}

*/