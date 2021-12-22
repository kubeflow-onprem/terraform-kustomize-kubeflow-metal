data "kustomization_build" "notebooks" {
  path = "kubeflow/manifests-${var.kubeflow_version}/apps/jupyter/notebook-controller/upstream/overlays/kubeflow"
}

data "kustomization_build" "jupyter" {
  path = "kubeflow/manifests-${var.kubeflow_version}/apps/jupyter/jupyter-web-app/upstream/overlays/istio"
}

resource "kustomization_resource" "notebooks_manifests_priority_1" {
  for_each = data.kustomization_build.notebooks.ids_prio[0]

  manifest = data.kustomization_build.notebooks.manifests[each.value]

  depends_on = [
    kustomization_resource.admission_webhook_manifests_priority_1,
    kustomization_resource.admission_webhook_manifests_priority_2,
    kustomization_resource.admission_webhook_manifests_priority_3
  ]
}

resource "kustomization_resource" "notebooks_manifests_priority_2" {
  for_each = data.kustomization_build.notebooks.ids_prio[1]
  manifest = data.kustomization_build.notebooks.manifests[each.value]

  depends_on = [
    kustomization_resource.notebooks_manifests_priority_1,
    kustomization_resource.admission_webhook_manifests_priority_1,
    kustomization_resource.admission_webhook_manifests_priority_2,
    kustomization_resource.admission_webhook_manifests_priority_3
  ]
}

resource "kustomization_resource" "notebooks_manifests_priority_3" {
  for_each = data.kustomization_build.notebooks.ids_prio[2]
  manifest = data.kustomization_build.notebooks.manifests[each.value]

  depends_on = [
    kustomization_resource.notebooks_manifests_priority_1,
    kustomization_resource.notebooks_manifests_priority_2,
    kustomization_resource.admission_webhook_manifests_priority_1,
    kustomization_resource.admission_webhook_manifests_priority_2,
    kustomization_resource.admission_webhook_manifests_priority_3
  ]
}

resource "kustomization_resource" "jupyter_manifests_priority_1" {
  for_each = data.kustomization_build.jupyter.ids_prio[0]

  manifest = data.kustomization_build.jupyter.manifests[each.value]

  depends_on = [
    kustomization_resource.notebooks_manifests_priority_1,
    kustomization_resource.notebooks_manifests_priority_2,
    kustomization_resource.notebooks_manifests_priority_3
  ]
}

resource "kustomization_resource" "jupyter_manifests_priority_2" {
  for_each = data.kustomization_build.jupyter.ids_prio[1]
  manifest = data.kustomization_build.jupyter.manifests[each.value]

  depends_on = [
    kustomization_resource.jupyter_manifests_priority_1,
    kustomization_resource.notebooks_manifests_priority_1,
    kustomization_resource.notebooks_manifests_priority_2,
    kustomization_resource.notebooks_manifests_priority_3
  ]
}

resource "kustomization_resource" "jupyter_manifests_priority_3" {
  for_each = data.kustomization_build.jupyter.ids_prio[2]
  manifest = data.kustomization_build.jupyter.manifests[each.value]

  depends_on = [
    kustomization_resource.jupyter_manifests_priority_1,
    kustomization_resource.jupyter_manifests_priority_2,
    kustomization_resource.notebooks_manifests_priority_1,
    kustomization_resource.notebooks_manifests_priority_2,
    kustomization_resource.notebooks_manifests_priority_3
  ]
}
