data "kustomization_build" "kubeflow_volumes" {
  path = "kubeflow/manifests-${var.kubeflow_version}/apps/volumes-web-app/upstream/overlays/istio"
}

resource "kustomization_resource" "kubeflow_volumes_manifests_priority_1" {
  for_each = data.kustomization_build.kubeflow_volumes.ids_prio[0]

  manifest = data.kustomization_build.kubeflow_volumes.manifests[each.value]

  depends_on = [
    kustomization_resource.kubeflow_profiles_manifests_priority_1,
    kustomization_resource.kubeflow_profiles_manifests_priority_2,
    kustomization_resource.kubeflow_profiles_manifests_priority_3
  ]
}

resource "kustomization_resource" "kubeflow_volumes_manifests_priority_2" {
  for_each = data.kustomization_build.kubeflow_volumes.ids_prio[1]
  manifest = data.kustomization_build.kubeflow_volumes.manifests[each.value]

  depends_on = [
    kustomization_resource.kubeflow_volumes_manifests_priority_1,
    kustomization_resource.kubeflow_profiles_manifests_priority_1,
    kustomization_resource.kubeflow_profiles_manifests_priority_2,
    kustomization_resource.kubeflow_profiles_manifests_priority_3
  ]
}

resource "kustomization_resource" "kubeflow_volumes_manifests_priority_3" {
  for_each = data.kustomization_build.kubeflow_volumes.ids_prio[2]
  manifest = data.kustomization_build.kubeflow_volumes.manifests[each.value]

  depends_on = [
    kustomization_resource.kubeflow_volumes_manifests_priority_1,
    kustomization_resource.kubeflow_volumes_manifests_priority_2,
    kustomization_resource.kubeflow_profiles_manifests_priority_1,
    kustomization_resource.kubeflow_profiles_manifests_priority_2,
    kustomization_resource.kubeflow_profiles_manifests_priority_3
  ]
}
