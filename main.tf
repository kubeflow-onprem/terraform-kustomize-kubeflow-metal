module "multiarch-k8s" {
  source = "/Users/keith/Projects/terraform-metal-multiarch-k8s"
  # source  = "equinix/multiarch-k8s/metal" # not the correct version; use a local version until equinix publishes a new one
  # version = "0.3.0"

  auth_token           = var.auth_token
  metal_create_project = false
  project_id           = var.project_id
  metro                = var.metro
  count_arm            = var.count_arm
  count_x86            = var.count_x86
  ccm_enabled          = true
  loadbalancer_type    = "kube-vip"
}

data "kustomization_build" "kubeflow_build" {
  path = "kubeflow/manifests-${var.kubeflow_version}/example"
}

resource "kustomization_resource" "kubeflow_manifests_priority_1" {
  for_each = data.kustomization_build.kubeflow_build.ids_prio[0]

  manifest = data.kustomization_build.kubeflow_build.manifests[each.value]
}

resource "kustomization_resource" "kubeflow_manifests_priority_2" {
  for_each = data.kustomization_build.kubeflow_build.ids_prio[1]
  manifest = data.kustomization_build.kubeflow_build.manifests[each.value]

  depends_on = [
    kustomization_resource.kubeflow_manifests_priority_1
  ]
}

resource "kustomization_resource" "kubeflow_manifests_priority_3" {
  for_each = data.kustomization_build.kubeflow_build.ids_prio[2]
  manifest = data.kustomization_build.kubeflow_build.manifests[each.value]

  depends_on = [
    kustomization_resource.kubeflow_manifests_priority_2
  ]
}

