data "kustomization_build" "admission_webhook" {
  path = "kubeflow/manifests-${var.kubeflow_version}/apps/admission-webhook/upstream/overlays/cert-manager"
}

resource "kustomization_resource" "admission_webhook_manifests_priority_1" {
  for_each = data.kustomization_build.admission_webhook.ids_prio[0]

  manifest = data.kustomization_build.admission_webhook.manifests[each.value]

  depends_on = [
    kustomization_resource.kubeflow_centraldashboard_manifests_priority_1,
    kustomization_resource.kubeflow_centraldashboard_manifests_priority_2,
    kustomization_resource.kubeflow_centraldashboard_manifests_priority_3
  ]
}

resource "kustomization_resource" "admission_webhook_manifests_priority_2" {
  for_each = data.kustomization_build.admission_webhook.ids_prio[1]
  manifest = data.kustomization_build.admission_webhook.manifests[each.value]

  depends_on = [
    kustomization_resource.admission_webhook_manifests_priority_1,
    kustomization_resource.kubeflow_centraldashboard_manifests_priority_1,
    kustomization_resource.kubeflow_centraldashboard_manifests_priority_2,
    kustomization_resource.kubeflow_centraldashboard_manifests_priority_3
  ]
}

resource "kustomization_resource" "admission_webhook_manifests_priority_3" {
  for_each = data.kustomization_build.admission_webhook.ids_prio[2]
  manifest = data.kustomization_build.admission_webhook.manifests[each.value]

  depends_on = [
    kustomization_resource.admission_webhook_manifests_priority_1,
    kustomization_resource.admission_webhook_manifests_priority_2,
    kustomization_resource.kubeflow_centraldashboard_manifests_priority_1,
    kustomization_resource.kubeflow_centraldashboard_manifests_priority_2,
    kustomization_resource.kubeflow_centraldashboard_manifests_priority_3
  ]
}
