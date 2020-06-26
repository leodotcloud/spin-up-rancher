resource "linode_domain_record" "rancher_dns_record" {
    domain_id = data.linode_domain.linode_domain_for_rancher.id
    name = var.label_prefix
    record_type = "A"
    target = linode_nodebalancer.rke-lb.ipv4
    ttl_sec = "300"
}
