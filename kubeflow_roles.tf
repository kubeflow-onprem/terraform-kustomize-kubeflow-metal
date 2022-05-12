data "kustomization_build" "kubeflow_roles" {
  path = "${path.root}/${var.kubeflow_path}/manifests-${var.kubeflow_version}/common/kubeflow-roles/base"
}

resource "kustomization_resource" "kubeflow_roles_manifests_priority_1" {
  for_each = data.kustomization_build.kubeflow_roles.ids_prio[0]

  manifest = data.kustomization_build.kubeflow_roles.manifests[each.value]

  depends_on = [
    kustomization_resource.kubeflow_namespace_manifests_priority_1,
    kustomization_resource.kubeflow_namespace_manifests_priority_2,
    kustomization_resource.kubeflow_namespace_manifests_priority_3
  ]
}

resource "kustomization_resource" "kubeflow_roles_manifests_priority_2" {
  for_each = data.kustomization_build.kubeflow_roles.ids_prio[1]
  manifest = data.kustomization_build.kubeflow_roles.manifests[each.value]

  depends_on = [
    kustomization_resource.kubeflow_roles_manifests_priority_1,
    kustomization_resource.kubeflow_namespace_manifests_priority_1,
    kustomization_resource.kubeflow_namespace_manifests_priority_2,
    kustomization_resource.kubeflow_namespace_manifests_priority_3
  ]
}

resource "kustomization_resource" "kubeflow_roles_manifests_priority_3" {
  for_each = data.kustomization_build.kubeflow_roles.ids_prio[2]
  manifest = data.kustomization_build.kubeflow_roles.manifests[each.value]

  depends_on = [
    kustomization_resource.kubeflow_roles_manifests_priority_1,
    kustomization_resource.kubeflow_roles_manifests_priority_2,
    kustomization_resource.kubeflow_namespace_manifests_priority_1,
    kustomization_resource.kubeflow_namespace_manifests_priority_2,
    kustomization_resource.kubeflow_namespace_manifests_priority_3
  ]
}
