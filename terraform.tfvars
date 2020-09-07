prefix               =  //keep it within 3-5 letters as the code is also generating unique petname along with it.
project_id           = "Your-GCP-Project-Id"
network              = "elastic-vpc-network"
elastic_subnet       = "elastic-subnet"
region               = "australia-southeast1"
elastic_subnet_cidr  = "10.10.0.0/24"
elastic_machine_type = "n1-standard-2"
zones                = "australia-southeast1-a"

kibana_machine_type = "e2-medium"
kibana_gce_image    = "kibana-7-8-1"
kibana_subnet       = "kibana-subnet"
kibana_subnet_cidr  = "10.20.0.0/24"

ports_to_open           = ["80", "9200", "443", "9300", "3000"]
machine_access_scopes   = ["cloud-platform", "userinfo-email", "compute-ro", "storage-rw", "monitoring-write", "logging-write", "https://www.googleapis.com/auth/trace.append"]
elasticsearch_gce_image = "elasticsearch-7-8-1"
elastic_node_ips        = ["10.10.0.1", "10.10.0.2", "10.10.0.3"]
master_elastic_node     = "elastic_master_node"
elastic_password        = "elasticpassword"
elastic_cluster_size    = 3
elastic_cluster_name    = "elasticsearch"