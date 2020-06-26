terraform {
  required_providers {
    linode = "~> 1.12"
    local = "~> 1.4"
    helm = "~> 1.2"
  }
}

provider "linode" {
  token = var.linode_api_token
}

provider "helm" {
  kubernetes {
    config_path = local_file.kube_config_cluster_yaml.filename
  }
}

