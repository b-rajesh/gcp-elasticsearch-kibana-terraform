# revisit to check autoscaling and also assign the instance groups to different zones. 
resource "google_compute_instance_group" "primary-elastic-compute-instance-group" {
  name      = "${random_pet.pet-prefix.id}-primary-elastic-compute-ig"
  network   = google_compute_network.elastic-vpc.id
  instances = [google_compute_instance.primary-elastic-compute.self_link]
  zone      = var.zones
  lifecycle {
    create_before_destroy = true
  }
  named_port {
    name = "http-80"
    port = "80"
  }
  named_port {
    name = "https-443"
    port = "443"
  }
  named_port {
    name = "http-9200"
    port = "9200"
  }
  named_port {
    name = "http-9300"
    port = "9300"
  }
  named_port {
    name = "http-3000"
    port = "3000"
  }
}
# revisit to check autoscaling and also assign the instance groups to different zones. 
resource "google_compute_instance_group" "secondary-elastic-compute-instance-group" {
  name    = "${random_pet.pet-prefix.id}-secondary-elastic-compute-ig"
  network = google_compute_network.elastic-vpc.id
  instances = [
    google_compute_instance.secondary-elastic-compute-1.self_link,
  google_compute_instance.secondary-elastic-compute-2.self_link]
  zone = var.zones
  lifecycle {
    create_before_destroy = true
  }
  named_port {
    name = "http-80"
    port = "80"
  }
  named_port {
    name = "https-443"
    port = "443"
  }
  named_port {
    name = "http-9200"
    port = "9200"
  }
  named_port {
    name = "http-9300"
    port = "9300"
  }
  named_port {
    name = "http-3000"
    port = "3000"
  }
}

