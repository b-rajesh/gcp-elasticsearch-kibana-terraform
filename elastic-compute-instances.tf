#https://towardsdatascience.com/automate-elasticsearch-deployment-in-gcp-part-1-terraform-3f51b4fcf5e6
#https://github.com/danisla/terraform-google-elasticsearch
#https://github.com/AckeeCZ/terraform-gcp-elasticsearch


resource "google_compute_address" "elastic_instance_private_ips" {
  count        = var.elastic_cluster_size
  name         = "${random_pet.pet-prefix.id}-elastic-ips-${count.index}"
  subnetwork   = google_compute_subnetwork.elastic-subnet.id
  address_type = "INTERNAL"
  region       = var.region
}

resource "google_compute_instance" "primary-elastic-compute" {
  name                      = "${random_pet.pet-prefix.id}-primary-elastic-compute"
  machine_type              = var.elastic_machine_type
  zone                      = var.zones
  allow_stopping_for_update = true
  tags                      = ["${random_pet.pet-prefix.id}-elastic-server"]

  boot_disk {
    initialize_params {
      image = var.elasticsearch_gce_image
      size  = 200
      type  = "pd-ssd"
    }
  }
  network_interface {
    network    = google_compute_network.elastic-vpc.id
    subnetwork = google_compute_subnetwork.elastic-subnet.id
    network_ip = google_compute_address.elastic_instance_private_ips[0].address
  }
  service_account {
    scopes = var.machine_access_scopes
    //email = google_service_account.elastic-backup.email
  }

  metadata_startup_script = templatefile("./elasticsearch_yml.sh", {
    node_name      = "${random_pet.pet-prefix.id}-${var.master_elastic_node}",
    network_host   = google_compute_address.elastic_instance_private_ips[0].address,
    elastic_host_1 = google_compute_address.elastic_instance_private_ips[0].address,
    elastic_host_2 = google_compute_address.elastic_instance_private_ips[1].address,
    elastic_host_3 = google_compute_address.elastic_instance_private_ips[2].address,
    cluster_name   = "${random_pet.pet-prefix.id}-${var.elastic_cluster_name}",
    master_node    = "${random_pet.pet-prefix.id}-${var.master_elastic_node}"
  })

}

resource "google_compute_instance" "secondary-elastic-compute-1" {
  name                      = "${random_pet.pet-prefix.id}-secondary-elastic-compute-1"
  machine_type              = var.elastic_machine_type
  zone                      = var.zones
  allow_stopping_for_update = true
  tags                      = ["${random_pet.pet-prefix.id}-elastic-server"]

  boot_disk {
    initialize_params {
      image = var.elasticsearch_gce_image
      size  = 200
      type  = "pd-ssd"
    }
  }
  network_interface {
    network    = google_compute_network.elastic-vpc.id
    subnetwork = google_compute_subnetwork.elastic-subnet.id
    network_ip = google_compute_address.elastic_instance_private_ips[1].address
  }
  service_account {
    scopes = var.machine_access_scopes
    //email = google_service_account.elastic-backup.email
  }

  metadata_startup_script = templatefile("./elasticsearch_yml.sh", {
    node_name      = "${random_pet.pet-prefix.id}-secondary-elastic-compute-1",
    network_host   = google_compute_address.elastic_instance_private_ips[1].address,
    elastic_host_1 = google_compute_address.elastic_instance_private_ips[0].address,
    elastic_host_2 = google_compute_address.elastic_instance_private_ips[1].address,
    elastic_host_3 = google_compute_address.elastic_instance_private_ips[2].address,
    cluster_name   = "${random_pet.pet-prefix.id}-${var.elastic_cluster_name}",
    master_node    = "${random_pet.pet-prefix.id}-${var.master_elastic_node}"
  })

}

resource "google_compute_instance" "secondary-elastic-compute-2" {
  name                      = "${random_pet.pet-prefix.id}-secondary-elastic-compute-2"
  machine_type              = var.elastic_machine_type
  zone                      = var.zones
  allow_stopping_for_update = true
  tags                      = ["${random_pet.pet-prefix.id}-elastic-server"]

  boot_disk {
    initialize_params {
      image = var.elasticsearch_gce_image
      size  = 200
      type  = "pd-ssd"
    }
  }
  network_interface {
    network    = google_compute_network.elastic-vpc.id
    subnetwork = google_compute_subnetwork.elastic-subnet.id
    network_ip = google_compute_address.elastic_instance_private_ips[2].address
  }
  service_account {
    scopes = var.machine_access_scopes
    //email = google_service_account.elastic-backup.email
  }

  metadata_startup_script = templatefile("./elasticsearch_yml.sh", {
    node_name      = "${random_pet.pet-prefix.id}-secondary-elastic-compute_2",
    network_host   = google_compute_address.elastic_instance_private_ips[2].address,
    elastic_host_1 = google_compute_address.elastic_instance_private_ips[0].address,
    elastic_host_2 = google_compute_address.elastic_instance_private_ips[1].address,
    elastic_host_3 = google_compute_address.elastic_instance_private_ips[2].address,
    cluster_name   = "${random_pet.pet-prefix.id}-${var.elastic_cluster_name}",
    master_node    = "${random_pet.pet-prefix.id}-${var.master_elastic_node}"
  })

}