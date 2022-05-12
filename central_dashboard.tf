data "kustomization_build" "kubeflow_centraldashboard" {
  path = "${path.root}/${var.kubeflow_path}/manifests-${var.kubeflow_version}/apps/centraldashboard/upstream/overlays/istio"
}

resource "kustomization_resource" "kubeflow_centraldashboard_manifests_priority_1" {
  for_each = data.kustomization_build.kubeflow_centraldashboard.ids_prio[0]

  manifest = data.kustomization_build.kubeflow_centraldashboard.manifests[each.value]

  depends_on = [
    kustomization_resource.kubeflow_katib_manifests_priority_1,
    kustomization_resource.kubeflow_katib_manifests_priority_2,
    kustomization_resource.kubeflow_katib_manifests_priority_3
  ]
}

resource "kustomization_resource" "kubeflow_centraldashboard_manifests_priority_2" {
  for_each = data.kustomization_build.kubeflow_centraldashboard.ids_prio[1]
  manifest = data.kustomization_build.kubeflow_centraldashboard.manifests[each.value]

  depends_on = [
    kustomization_resource.kubeflow_centraldashboard_manifests_priority_1,
    kustomization_resource.kubeflow_katib_manifests_priority_1,
    kustomization_resource.kubeflow_katib_manifests_priority_2,
    kustomization_resource.kubeflow_katib_manifests_priority_3
  ]
}

resource "kustomization_resource" "kubeflow_centraldashboard_manifests_priority_3" {
  for_each = data.kustomization_build.kubeflow_centraldashboard.ids_prio[2]
  manifest = data.kustomization_build.kubeflow_centraldashboard.manifests[each.value]

  depends_on = [
    kustomization_resource.kubeflow_centraldashboard_manifests_priority_1,
    kustomization_resource.kubeflow_centraldashboard_manifests_priority_2,
    kustomization_resource.kubeflow_katib_manifests_priority_1,
    kustomization_resource.kubeflow_katib_manifests_priority_2,
    kustomization_resource.kubeflow_katib_manifests_priority_3
  ]
}
