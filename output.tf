output "kibana_dashboard_url" {
  description = "Kibana Dashboard"
  value       = "http://${google_compute_global_forwarding_rule.kibana_external_lb.ip_address}:8080"
}

