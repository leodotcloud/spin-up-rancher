resource "linode_instance" "rke" {
  count = var.rke_node_count
  image = var.instance_image
  label = "${var.label_prefix}-rke-h${count.index + 1}"
  region = var.region
  type = var.instance_type
  authorized_keys = var.authorized_keys
  root_pass = var.root_pass
  private_ip = true

  connection {
    host = self.ip_address
    type     = "ssh"
    user     = var.ssh_user
    private_key = file(var.ssh_private_key_path)
  }

  provisioner "remote-exec" {
    inline = [
      "export DEBIAN_FRONTEND=noninteractive;curl -sSL https://raw.githubusercontent.com/rancher/install-docker/master/${var.docker_version}.sh | sh -"
    ]
  }
}

resource "rke_cluster" "K8S" {
  dynamic "nodes" {
    for_each = linode_instance.rke.*.ip_address 
    content {
      address          = nodes.value
      user             = "root"
      role             = ["etcd", "controlplane", "worker"]
    }
  }
  addon_job_timeout = 120
  ingress {
    provider = "nginx"
    options = {
      use-forwarded-headers = "true"
    }
  }
}

resource "local_file" "kube_config_cluster_yaml" {
  filename = "${path.root}/kube_config_cluster.yml"
  content  = rke_cluster.K8S.kube_config_yaml
}

