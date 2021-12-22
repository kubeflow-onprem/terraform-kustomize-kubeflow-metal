data "kustomization_build" "kubeflow_pipelines" {
  path = "kubeflow/manifests-${var.kubeflow_version}/apps/pipeline/upstream/env/platform-agnostic-multi-user"
}

resource "kustomization_resource" "kubeflow_pipelines_manifests_priority_1" {
  for_each = data.kustomization_build.kubeflow_pipelines.ids_prio[0]

  manifest = data.kustomization_build.kubeflow_pipelines.manifests[each.value]

  depends_on = [
    kustomization_resource.kubeflow_istio_manifests_priority_1,
    kustomization_resource.kubeflow_istio_manifests_priority_2,
    kustomization_resource.kubeflow_istio_manifests_priority_3
  ]
}

resource "kustomization_resource" "kubeflow_pipelines_manifests_priority_2" {
  for_each = data.kustomization_build.kubeflow_pipelines.ids_prio[1]
  manifest = data.kustomization_build.kubeflow_pipelines.manifests[each.value]

  depends_on = [
    kustomization_resource.kubeflow_pipelines_manifests_priority_1,
    kustomization_resource.kubeflow_istio_manifests_priority_1,
    kustomization_resource.kubeflow_istio_manifests_priority_2,
    kustomization_resource.kubeflow_istio_manifests_priority_3
  ]
}

resource "kustomization_resource" "kubeflow_pipelines_manifests_priority_3" {
  for_each = data.kustomization_build.kubeflow_pipelines.ids_prio[2]
  manifest = data.kustomization_build.kubeflow_pipelines.manifests[each.value]

  depends_on = [
    kustomization_resource.kubeflow_pipelines_manifests_priority_1,
    kustomization_resource.kubeflow_pipelines_manifests_priority_2,
    kustomization_resource.kubeflow_istio_manifests_priority_1,
    kustomization_resource.kubeflow_istio_manifests_priority_2,
    kustomization_resource.kubeflow_istio_manifests_priority_3
  ]
}
