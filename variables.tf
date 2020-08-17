variable "network" {}
variable "elastic_subnet" {}
variable "project_id" {}
variable "region" {}
variable "elastic_subnet_cidr" {}
variable "elastic_machine_type" {}
variable "zones" {}
variable "prefix" {}
variable "elastic_node_ips" {}
variable "master_elastic_node" {}
variable "elastic_password" {}
variable "elasticsearch_gce_image" {}
variable "machine_access_scopes" {}
variable "kibana_subnet_cidr" {}
variable "ports_to_open" {}
variable "elastic_cluster_name" {}
variable "elastic_cluster_size" {}
variable "kibana_machine_type" {}
variable "kibana_subnet" {}
variable "kibana_gce_image" {}
variable "allowed_inbound_cidr_blocks_ssh" {
  description = "A list of CIDR-formatted IP address ranges from which the Compute Instances will allow SSH connections to Consul."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}
