data "kustomization_build" "mpi_operator" {
  path = "${path.root}/${var.kubeflow_path}/manifests-${var.kubeflow_version}/apps/mpi-job/upstream/overlays/kubeflow"
}

resource "kustomization_resource" "mpi_operator_manifests_priority_1" {
  for_each = data.kustomization_build.mpi_operator.ids_prio[0]

  manifest = data.kustomization_build.mpi_operator.manifests[each.value]

  depends_on = [
    kustomization_resource.training_operator_manifests_priority_1,
    kustomization_resource.training_operator_manifests_priority_2,
    kustomization_resource.training_operator_manifests_priority_3
  ]
}

resource "kustomization_resource" "mpi_operator_manifests_priority_2" {
  for_each = data.kustomization_build.mpi_operator.ids_prio[1]
  manifest = data.kustomization_build.mpi_operator.manifests[each.value]

  depends_on = [
    kustomization_resource.mpi_operator_manifests_priority_1,
    kustomization_resource.training_operator_manifests_priority_1,
    kustomization_resource.training_operator_manifests_priority_2,
    kustomization_resource.training_operator_manifests_priority_3
  ]
}

resource "kustomization_resource" "mpi_operator_manifests_priority_3" {
  for_each = data.kustomization_build.mpi_operator.ids_prio[2]
  manifest = data.kustomization_build.mpi_operator.manifests[each.value]

  depends_on = [
    kustomization_resource.mpi_operator_manifests_priority_1,
    kustomization_resource.mpi_operator_manifests_priority_2,
    kustomization_resource.training_operator_manifests_priority_1,
    kustomization_resource.training_operator_manifests_priority_2,
    kustomization_resource.training_operator_manifests_priority_3
  ]
}
