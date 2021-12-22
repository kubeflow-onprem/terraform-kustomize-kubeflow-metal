data "kustomization_build" "kubeflow_dex" {
  path = "kubeflow/manifests-${var.kubeflow_version}/common/dex/overlays/istio"
}

resource "kustomization_resource" "kubeflow_dex_manifests_priority_1" {
  for_each = data.kustomization_build.kubeflow_dex.ids_prio[0]

  manifest = data.kustomization_build.kubeflow_dex.manifests[each.value]

  depends_on = [
    kustomization_resource.kubeflow_istio_install_manifests_priority_1,
    kustomization_resource.kubeflow_istio_install_manifests_priority_2,
    kustomization_resource.kubeflow_istio_install_manifests_priority_3
  ]
}

resource "kustomization_resource" "kubeflow_dex_manifests_priority_2" {
  for_each = data.kustomization_build.kubeflow_dex.ids_prio[1]
  manifest = data.kustomization_build.kubeflow_dex.manifests[each.value]

  depends_on = [
    kustomization_resource.kubeflow_dex_manifests_priority_1,
    kustomization_resource.kubeflow_istio_install_manifests_priority_1,
    kustomization_resource.kubeflow_istio_install_manifests_priority_2,
    kustomization_resource.kubeflow_istio_install_manifests_priority_3
  ]
}

resource "kustomization_resource" "kubeflow_dex_manifests_priority_3" {
  for_each = data.kustomization_build.kubeflow_dex.ids_prio[2]
  manifest = data.kustomization_build.kubeflow_dex.manifests[each.value]

  depends_on = [
    kustomization_resource.kubeflow_dex_manifests_priority_1,
    kustomization_resource.kubeflow_dex_manifests_priority_2,
    kustomization_resource.kubeflow_istio_install_manifests_priority_1,
    kustomization_resource.kubeflow_istio_install_manifests_priority_2,
    kustomization_resource.kubeflow_istio_install_manifests_priority_3
  ]
}
