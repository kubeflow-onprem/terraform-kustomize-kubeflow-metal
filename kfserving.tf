data "kustomization_build" "kubeflow_kfserving" {
  path = "kubeflow/manifests-${var.kubeflow_version}/apps/kfserving/upstream/overlays/kubeflow"
}

resource "kustomization_resource" "kubeflow_kfserving_manifests_priority_1" {
  for_each = data.kustomization_build.kubeflow_kfserving.ids_prio[0]

  manifest = data.kustomization_build.kubeflow_kfserving.manifests[each.value]

  depends_on = [
    kustomization_resource.kubeflow_pipelines_manifests_priority_1,
    kustomization_resource.kubeflow_pipelines_manifests_priority_2,
    kustomization_resource.kubeflow_pipelines_manifests_priority_3
  ]
}

resource "kustomization_resource" "kubeflow_kfserving_manifests_priority_2" {
  for_each = data.kustomization_build.kubeflow_kfserving.ids_prio[1]
  manifest = data.kustomization_build.kubeflow_kfserving.manifests[each.value]

  depends_on = [
    kustomization_resource.kubeflow_kfserving_manifests_priority_1,
    kustomization_resource.kubeflow_pipelines_manifests_priority_1,
    kustomization_resource.kubeflow_pipelines_manifests_priority_2,
    kustomization_resource.kubeflow_pipelines_manifests_priority_3
  ]
}

resource "kustomization_resource" "kubeflow_kfserving_manifests_priority_3" {
  for_each = data.kustomization_build.kubeflow_kfserving.ids_prio[2]
  manifest = data.kustomization_build.kubeflow_kfserving.manifests[each.value]

  depends_on = [
    kustomization_resource.kubeflow_kfserving_manifests_priority_1,
    kustomization_resource.kubeflow_kfserving_manifests_priority_2,
    kustomization_resource.kubeflow_pipelines_manifests_priority_1,
    kustomization_resource.kubeflow_pipelines_manifests_priority_2,
    kustomization_resource.kubeflow_pipelines_manifests_priority_3
  ]
}
