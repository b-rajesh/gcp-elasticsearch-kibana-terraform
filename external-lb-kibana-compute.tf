resource "google_compute_http_health_check" "lb_kibana_health_check" {
  name                = "${random_pet.pet-prefix.id}-lb-kibana-health-check"
  port                = 5601
  request_path        = "/api/status"
}

resource "google_compute_backend_service" "kibana_backend_service" {
  name          = "kibana-backend-service"
  port_name = "kibana5601"
  backend {
    group = google_compute_instance_group.kibana_instance_group.id
  }
  health_checks = [google_compute_http_health_check.lb_kibana_health_check.id]
}

resource "google_compute_url_map" "kibana_url_map" {
  name            = "kibana-url-map-backend-service"
  description     = "a description"
  default_service = google_compute_backend_service.kibana_backend_service.id
}

resource "google_compute_target_http_proxy" "kibana_target_url_proxy" {
  name        = "kibana-url-target-proxy"
  description = "a description"
  url_map     = google_compute_url_map.kibana_url_map.id
}

resource "google_compute_global_forwarding_rule" "kibana_external_lb" {
  name       = "kibana-external-lb-global-rule"
  target     = google_compute_target_http_proxy.kibana_target_url_proxy.id
  port_range = "8080"
}
