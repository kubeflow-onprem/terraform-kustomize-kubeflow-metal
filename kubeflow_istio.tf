data "kustomization_build" "kubeflow_istio" {
  path = "${path.root}/${var.kubeflow_path}/manifests-${var.kubeflow_version}/common/istio-1-9/kubeflow-istio-resources/base"
}

resource "kustomization_resource" "kubeflow_istio_manifests_priority_1" {
  for_each = data.kustomization_build.kubeflow_istio.ids_prio[0]

  manifest = data.kustomization_build.kubeflow_istio.manifests[each.value]

  depends_on = [
    kustomization_resource.kubeflow_roles_manifests_priority_1,
    kustomization_resource.kubeflow_roles_manifests_priority_2,
    kustomization_resource.kubeflow_roles_manifests_priority_3
  ]
}

resource "kustomization_resource" "kubeflow_istio_manifests_priority_2" {
  for_each = data.kustomization_build.kubeflow_istio.ids_prio[1]
  manifest = data.kustomization_build.kubeflow_istio.manifests[each.value]

  depends_on = [
    kustomization_resource.kubeflow_istio_manifests_priority_1,
    kustomization_resource.kubeflow_roles_manifests_priority_1,
    kustomization_resource.kubeflow_roles_manifests_priority_2,
    kustomization_resource.kubeflow_roles_manifests_priority_3
  ]
}

resource "kustomization_resource" "kubeflow_istio_manifests_priority_3" {
  for_each = data.kustomization_build.kubeflow_istio.ids_prio[2]
  manifest = data.kustomization_build.kubeflow_istio.manifests[each.value]

  depends_on = [
    kustomization_resource.kubeflow_istio_manifests_priority_1,
    kustomization_resource.kubeflow_istio_manifests_priority_2,
    kustomization_resource.kubeflow_roles_manifests_priority_1,
    kustomization_resource.kubeflow_roles_manifests_priority_2,
    kustomization_resource.kubeflow_roles_manifests_priority_3

  ]
}
