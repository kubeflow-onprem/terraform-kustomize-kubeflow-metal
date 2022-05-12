data "kustomization_build" "tensorboard" {
  path = "${path.root}/${var.kubeflow_path}/manifests-${var.kubeflow_version}/apps/tensorboard/tensorboards-web-app/upstream/overlays/istio"
}

data "kustomization_build" "tensorboard_controller" {
  path = "${path.root}/${var.kubeflow_path}/manifests-${var.kubeflow_version}/apps/tensorboard/tensorboard-controller/upstream/overlays/kubeflow"
}

resource "kustomization_resource" "tensorboard_manifests_priority_1" {
  for_each = data.kustomization_build.tensorboard.ids_prio[0]

  manifest = data.kustomization_build.tensorboard.manifests[each.value]

  depends_on = [
    kustomization_resource.kubeflow_volumes_manifests_priority_1,
    kustomization_resource.kubeflow_volumes_manifests_priority_2,
    kustomization_resource.kubeflow_volumes_manifests_priority_3
  ]
}

resource "kustomization_resource" "tensorboard_manifests_priority_2" {
  for_each = data.kustomization_build.tensorboard.ids_prio[1]
  manifest = data.kustomization_build.tensorboard.manifests[each.value]

  depends_on = [
    kustomization_resource.tensorboard_manifests_priority_1,
    kustomization_resource.kubeflow_volumes_manifests_priority_1,
    kustomization_resource.kubeflow_volumes_manifests_priority_2,
    kustomization_resource.kubeflow_volumes_manifests_priority_3
  ]
}

resource "kustomization_resource" "tensorboard_manifests_priority_3" {
  for_each = data.kustomization_build.tensorboard.ids_prio[2]
  manifest = data.kustomization_build.tensorboard.manifests[each.value]

  depends_on = [
    kustomization_resource.tensorboard_manifests_priority_1,
    kustomization_resource.tensorboard_manifests_priority_2,
    kustomization_resource.kubeflow_volumes_manifests_priority_1,
    kustomization_resource.kubeflow_volumes_manifests_priority_2,
    kustomization_resource.kubeflow_volumes_manifests_priority_3
  ]
}

resource "kustomization_resource" "tensorboard_controller_manifests_priority_1" {
  for_each = data.kustomization_build.tensorboard_controller.ids_prio[0]

  manifest = data.kustomization_build.tensorboard_controller.manifests[each.value]

  depends_on = [
    kustomization_resource.tensorboard_manifests_priority_1,
    kustomization_resource.tensorboard_manifests_priority_2,
    kustomization_resource.tensorboard_manifests_priority_3
  ]
}

resource "kustomization_resource" "tensorboard_controller_manifests_priority_2" {
  for_each = data.kustomization_build.tensorboard_controller.ids_prio[1]
  manifest = data.kustomization_build.tensorboard_controller.manifests[each.value]

  depends_on = [
    kustomization_resource.tensorboard_controller_manifests_priority_1,
    kustomization_resource.tensorboard_manifests_priority_1,
    kustomization_resource.tensorboard_manifests_priority_2,
    kustomization_resource.tensorboard_manifests_priority_3
  ]
}

resource "kustomization_resource" "tensorboard_controller_manifests_priority_3" {
  for_each = data.kustomization_build.tensorboard_controller.ids_prio[2]
  manifest = data.kustomization_build.tensorboard_controller.manifests[each.value]

  depends_on = [
    kustomization_resource.tensorboard_controller_manifests_priority_1,
    kustomization_resource.tensorboard_controller_manifests_priority_2,
    kustomization_resource.tensorboard_manifests_priority_1,
    kustomization_resource.tensorboard_manifests_priority_2,
    kustomization_resource.tensorboard_manifests_priority_3
  ]
}
