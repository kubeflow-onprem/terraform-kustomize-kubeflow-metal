data "kustomization_build" "kubeflow_istio_crds" {
  path = "${path.root}/${var.kubeflow_path}/manifests-${var.kubeflow_version}/common/istio-1-9/istio-crds/base"
}

data "kustomization_build" "kubeflow_istio_namespace" {
  path = "${path.root}/${var.kubeflow_path}/manifests-${var.kubeflow_version}/common/istio-1-9/istio-namespace/base"
}

data "kustomization_build" "kubeflow_istio_install" {
  path = "${path.root}/${var.kubeflow_path}/manifests-${var.kubeflow_version}/common/istio-1-9/istio-install/base"
}

resource "kustomization_resource" "kubeflow_istio_crds_manifests_priority_1" {
  for_each = data.kustomization_build.kubeflow_istio_crds.ids_prio[0]

  manifest = data.kustomization_build.kubeflow_istio_crds.manifests[each.value]

  depends_on = [
    kustomization_resource.kubeflow_certmanager_issuer_manifests_priority_1,
    kustomization_resource.kubeflow_certmanager_issuer_manifests_priority_2,
    kustomization_resource.kubeflow_certmanager_issuer_manifests_priority_3
  ]
}

resource "kustomization_resource" "kubeflow_istio_crds_manifests_priority_2" {
  for_each = data.kustomization_build.kubeflow_istio_crds.ids_prio[1]
  manifest = data.kustomization_build.kubeflow_istio_crds.manifests[each.value]

  depends_on = [
    kustomization_resource.kubeflow_istio_crds_manifests_priority_1,
    kustomization_resource.kubeflow_certmanager_issuer_manifests_priority_1,
    kustomization_resource.kubeflow_certmanager_issuer_manifests_priority_2,
    kustomization_resource.kubeflow_certmanager_issuer_manifests_priority_3
  ]
}

resource "kustomization_resource" "kubeflow_istio_crds_manifests_priority_3" {
  for_each = data.kustomization_build.kubeflow_istio_crds.ids_prio[2]
  manifest = data.kustomization_build.kubeflow_istio_crds.manifests[each.value]

  depends_on = [
    kustomization_resource.kubeflow_istio_crds_manifests_priority_1,
    kustomization_resource.kubeflow_istio_crds_manifests_priority_2,
    kustomization_resource.kubeflow_certmanager_issuer_manifests_priority_1,
    kustomization_resource.kubeflow_certmanager_issuer_manifests_priority_2,
    kustomization_resource.kubeflow_certmanager_issuer_manifests_priority_3
  ]
}

resource "kustomization_resource" "kubeflow_istio_namespace_manifests_priority_1" {
  for_each = data.kustomization_build.kubeflow_istio_namespace.ids_prio[0]

  manifest = data.kustomization_build.kubeflow_istio_namespace.manifests[each.value]

  depends_on = [
    kustomization_resource.kubeflow_istio_crds_manifests_priority_1,
    kustomization_resource.kubeflow_istio_crds_manifests_priority_2,
    kustomization_resource.kubeflow_istio_crds_manifests_priority_3
  ]
}

resource "kustomization_resource" "kubeflow_istio_namespace_manifests_priority_2" {
  for_each = data.kustomization_build.kubeflow_istio_namespace.ids_prio[1]
  manifest = data.kustomization_build.kubeflow_istio_namespace.manifests[each.value]

  depends_on = [
    kustomization_resource.kubeflow_istio_crds_manifests_priority_1,
    kustomization_resource.kubeflow_istio_crds_manifests_priority_2,
    kustomization_resource.kubeflow_istio_crds_manifests_priority_3,
    kustomization_resource.kubeflow_istio_namespace_manifests_priority_1,
  ]
}

resource "kustomization_resource" "kubeflow_istio_namespace_manifests_priority_3" {
  for_each = data.kustomization_build.kubeflow_istio_namespace.ids_prio[2]
  manifest = data.kustomization_build.kubeflow_istio_namespace.manifests[each.value]

  depends_on = [
    kustomization_resource.kubeflow_istio_crds_manifests_priority_1,
    kustomization_resource.kubeflow_istio_crds_manifests_priority_2,
    kustomization_resource.kubeflow_istio_crds_manifests_priority_3,
    kustomization_resource.kubeflow_istio_namespace_manifests_priority_1,
    kustomization_resource.kubeflow_istio_namespace_manifests_priority_2,
  ]
}

resource "kustomization_resource" "kubeflow_istio_install_manifests_priority_1" {
  for_each = data.kustomization_build.kubeflow_istio_install.ids_prio[0]

  manifest = data.kustomization_build.kubeflow_istio_install.manifests[each.value]

  depends_on = [
    kustomization_resource.kubeflow_istio_namespace_manifests_priority_3,
    kustomization_resource.kubeflow_istio_namespace_manifests_priority_2,
    kustomization_resource.kubeflow_istio_namespace_manifests_priority_1,
  ]
}

resource "kustomization_resource" "kubeflow_istio_install_manifests_priority_2" {
  for_each = data.kustomization_build.kubeflow_istio_install.ids_prio[1]
  manifest = data.kustomization_build.kubeflow_istio_install.manifests[each.value]

  depends_on = [
    kustomization_resource.kubeflow_istio_install_manifests_priority_1,
    kustomization_resource.kubeflow_istio_namespace_manifests_priority_3,
    kustomization_resource.kubeflow_istio_namespace_manifests_priority_2,
    kustomization_resource.kubeflow_istio_namespace_manifests_priority_1,
  ]
}

resource "kustomization_resource" "kubeflow_istio_install_manifests_priority_3" {
  for_each = data.kustomization_build.kubeflow_istio_install.ids_prio[2]
  manifest = data.kustomization_build.kubeflow_istio_install.manifests[each.value]

  depends_on = [
    kustomization_resource.kubeflow_istio_install_manifests_priority_1,
    kustomization_resource.kubeflow_istio_install_manifests_priority_2,
    kustomization_resource.kubeflow_istio_namespace_manifests_priority_3,
    kustomization_resource.kubeflow_istio_namespace_manifests_priority_2,
    kustomization_resource.kubeflow_istio_namespace_manifests_priority_1,
  ]
}
