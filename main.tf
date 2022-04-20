module "multiarch-k8s" {
  source  = "equinix/multiarch-k8s/metal"
  version = "0.4.0"

  auth_token           = var.auth_token
  metal_create_project = false
  project_id           = var.project_id
  metro                = var.metro
  count_arm            = var.count_arm
  count_x86            = var.count_x86
  ccm_enabled          = true
  loadbalancer_type    = "kube-vip"
}

resource "kubernetes_namespace" "local-path-provisioner" {
  metadata {
    name = "local-path-provisioner"
  }

  depends_on = [
    module.multiarch-k8s
  ]
}

resource "helm_release" "local-path-provisioner" {
  name = "local-path-provisioner"

  repository = "https://ebrianne.github.io/helm-charts"
  chart      = "local-path-provisioner"
  namespace  = "local-path-provisioner"

  depends_on = [
    kubernetes_namespace.local-path-provisioner
  ]

  set {
    name  = "storageClass.defaultClass"
    value = true
  }
}


