data "kustomization_build" "kubeflow_certmanager" {
  path = "kubeflow/manifests-${var.kubeflow_version}/common/cert-manager/cert-manager/base"
}

data "kustomization_build" "kubeflow_certmanager_issuer" {
  path = "kubeflow/manifests-${var.kubeflow_version}/common/cert-manager/kubeflow-issuer/base"
}

resource "kustomization_resource" "kubeflow_certmanager_manifests_priority_1" {
  for_each = data.kustomization_build.kubeflow_certmanager.ids_prio[0]

  manifest = data.kustomization_build.kubeflow_certmanager.manifests[each.value]

  depends_on = [
    helm_release.local-path-provisioner
  ]
}

resource "kustomization_resource" "kubeflow_certmanager_manifests_priority_2" {
  for_each = data.kustomization_build.kubeflow_certmanager.ids_prio[1]
  manifest = data.kustomization_build.kubeflow_certmanager.manifests[each.value]

  depends_on = [
    kustomization_resource.kubeflow_certmanager_manifests_priority_1,
    helm_release.local-path-provisioner
  ]
}

resource "kustomization_resource" "kubeflow_certmanager_manifests_priority_3" {
  for_each = data.kustomization_build.kubeflow_certmanager.ids_prio[2]
  manifest = data.kustomization_build.kubeflow_certmanager.manifests[each.value]

  depends_on = [
    kustomization_resource.kubeflow_certmanager_manifests_priority_1,
    kustomization_resource.kubeflow_certmanager_manifests_priority_2,
    helm_release.local-path-provisioner
  ]
}

resource "kustomization_resource" "kubeflow_certmanager_issuer_manifests_priority_1" {
  for_each = data.kustomization_build.kubeflow_certmanager_issuer.ids_prio[0]

  manifest = data.kustomization_build.kubeflow_certmanager_issuer.manifests[each.value]

  depends_on = [
    kustomization_resource.kubeflow_certmanager_manifests_priority_1,
    kustomization_resource.kubeflow_certmanager_manifests_priority_2,
    kustomization_resource.kubeflow_certmanager_manifests_priority_3,
    helm_release.local-path-provisioner,
  ]
}

resource "null_resource" "sleep" {
  provisioner "local-exec" {
    command = "sleep 20" # Give the cert-manager service time to become READY
  }

  depends_on = [
    kustomization_resource.kubeflow_certmanager_manifests_priority_1,
    kustomization_resource.kubeflow_certmanager_manifests_priority_2,
    kustomization_resource.kubeflow_certmanager_manifests_priority_3,
    kustomization_resource.kubeflow_certmanager_issuer_manifests_priority_1,
  ]
}

resource "kustomization_resource" "kubeflow_certmanager_issuer_manifests_priority_2" {
  for_each = data.kustomization_build.kubeflow_certmanager_issuer.ids_prio[1]
  manifest = data.kustomization_build.kubeflow_certmanager_issuer.manifests[each.value]

  depends_on = [
    kustomization_resource.kubeflow_certmanager_issuer_manifests_priority_1,
    null_resource.sleep
  ]
}

resource "kustomization_resource" "kubeflow_certmanager_issuer_manifests_priority_3" {
  for_each = data.kustomization_build.kubeflow_certmanager_issuer.ids_prio[2]
  manifest = data.kustomization_build.kubeflow_certmanager_issuer.manifests[each.value]

  depends_on = [
    kustomization_resource.kubeflow_certmanager_issuer_manifests_priority_1,
    kustomization_resource.kubeflow_certmanager_issuer_manifests_priority_2,
  ]
}
