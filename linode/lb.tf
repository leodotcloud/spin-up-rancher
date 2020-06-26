resource "linode_nodebalancer" "rke-lb" {
    label = var.label_prefix
    region = var.region
}

resource "linode_nodebalancer_config" "rke-lb-config" {
    nodebalancer_id = linode_nodebalancer.rke-lb.id
    port = 443
    protocol = "https"
    ssl_cert = trimspace(file(var.ssl_cert))
    ssl_key = trimspace(file(var.ssl_key))
    check = "connection"
    check_attempts = 2
    check_timeout = 3
    check_interval = 5
    stickiness = "table"
    algorithm = "roundrobin"
}

resource "linode_nodebalancer_node" "rke-lb-node" {
    count = var.rke_node_count
    nodebalancer_id = linode_nodebalancer.rke-lb.id
    config_id = linode_nodebalancer_config.rke-lb-config.id
    label = "${var.label_prefix}-rke-h${count.index + 1}"
    address = "${element(linode_instance.rke.*.private_ip_address, count.index)}:80"
    mode = "accept"
}
