variable "linode_api_token" {
  description = "Your Linode APIv4 Access Token"
}

variable "linode_domain_for_rancher" {
  description = "Domain created in Linode, under which rancher DNS entry is created (Ex: mycompany.com)"
}

variable "label_prefix" {
  description = "Prefix to use for various resources, same is used for FQDN of rancher (Ex: label.mycompany.com)"
}

variable "instance_image" {
  description = "Linode Instance image to use"
  default = "linode/ubuntu18.04"
}

variable "instance_type" {
  description = "Linode Instance type"
  default = "g6-standard-4"
}

variable "region" {
  description = "Region where instance will be created (Ex: ap-west, us-west)"
}

variable "authorized_keys" {
  description = "SSH keys to be added to the linode instances"
}

variable "ssh_user" {
  description = "SSH username inside the instance image"
  default = "root"
}

variable "root_pass" {
  description = "Root password"
}

variable "ssh_private_key_path" {
  description = "Full filepath to SSH private key to login to instances"
  default = "~/.ssh/id_rsa"
}

variable "ssl_cert" {
  description = "Full filepath of SSL certificate"
}

variable "ssl_key" {
  description = "Full filepath of SSL certificate key"
}

variable "rke_node_count" {
  description = "Number of RKE cluster nodes"
  default = "3"
}

variable "docker_version" {
  description = "Docker version to use"
  default = "19.03.2"
}

variable "rancher_version" {
  description = "Version of Rancher to install"
}

variable "rancher_replicas" {
  description = "Number of replicas for Rancher deployment"
  default = "3"
}
