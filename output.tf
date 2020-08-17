output "kibana_dashboard_url" {
  description = "Kibana Dashboard"
  value       = "http://${google_compute_forwarding_rule.kibana_external_loadbalancer.ip_address}:8080"
}