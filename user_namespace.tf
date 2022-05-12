data "kustomization_build" "user_namespace" {
  path = "${path.root}/${var.kubeflow_path}/manifests-${var.kubeflow_version}/common/user-namespace/base"
}

resource "kustomization_resource" "user_namespace_manifests_priority_1" {
  for_each = data.kustomization_build.user_namespace.ids_prio[0]

  manifest = data.kustomization_build.user_namespace.manifests[each.value]

  depends_on = [
    kustomization_resource.mpi_operator_manifests_priority_1,
    kustomization_resource.mpi_operator_manifests_priority_2,
    kustomization_resource.mpi_operator_manifests_priority_3
  ]
}

resource "kustomization_resource" "user_namespace_manifests_priority_2" {
  for_each = data.kustomization_build.user_namespace.ids_prio[1]
  manifest = data.kustomization_build.user_namespace.manifests[each.value]

  depends_on = [
    kustomization_resource.user_namespace_manifests_priority_1,
    kustomization_resource.mpi_operator_manifests_priority_1,
    kustomization_resource.mpi_operator_manifests_priority_2,
    kustomization_resource.mpi_operator_manifests_priority_3
  ]
}

resource "kustomization_resource" "user_namespace_manifests_priority_3" {
  for_each = data.kustomization_build.user_namespace.ids_prio[2]
  manifest = data.kustomization_build.user_namespace.manifests[each.value]

  depends_on = [
    kustomization_resource.user_namespace_manifests_priority_1,
    kustomization_resource.user_namespace_manifests_priority_2,
    kustomization_resource.mpi_operator_manifests_priority_1,
    kustomization_resource.mpi_operator_manifests_priority_2,
    kustomization_resource.mpi_operator_manifests_priority_3
  ]
}
