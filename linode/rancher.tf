resource "helm_release" "rancher" {
  name             = "rancher"
  repository       = "https://releases.rancher.com/server-charts/latest" 
  chart            = "rancher"
  version          = var.rancher_version
  namespace        = "cattle-system"
  create_namespace = "true"

  set {
    name  = "hostname"
    value = "${var.label_prefix}.${var.linode_domain_for_rancher}"
  }

  set {
    name  = "tls"
    value = "external"
  }

  set {
    name  = "replicas"
    value = var.rancher_replicas
  }
}
