data "kustomization_build" "kubeflow_knative_serving" {
  path = "kubeflow/manifests-${var.kubeflow_version}/common/knative/knative-serving/base"
}

data "kustomization_build" "kubeflow_cluster_local_gateway" {
  path = "kubeflow/manifests-${var.kubeflow_version}/common/istio-1-9/cluster-local-gateway/base"
}

data "kustomization_build" "kubeflow_knative_eventing" {
  path = "kubeflow/manifests-${var.kubeflow_version}/common/knative/knative-eventing/base"
}

resource "kustomization_resource" "kubeflow_knative_serving_manifests_priority_1" {
  for_each = data.kustomization_build.kubeflow_knative_serving.ids_prio[0]

  manifest = data.kustomization_build.kubeflow_knative_serving.manifests[each.value]

  depends_on = [
    kustomization_resource.kubeflow_oidc_manifests_priority_1,
    kustomization_resource.kubeflow_oidc_manifests_priority_2,
    kustomization_resource.kubeflow_oidc_manifests_priority_3,
  ]
}

resource "kustomization_resource" "kubeflow_knative_serving_manifests_priority_2" {
  for_each = data.kustomization_build.kubeflow_knative_serving.ids_prio[1]
  manifest = data.kustomization_build.kubeflow_knative_serving.manifests[each.value]

  depends_on = [
    kustomization_resource.kubeflow_knative_serving_manifests_priority_1,
    kustomization_resource.kubeflow_oidc_manifests_priority_1,
    kustomization_resource.kubeflow_oidc_manifests_priority_2,
    kustomization_resource.kubeflow_oidc_manifests_priority_3,
  ]
}

resource "kustomization_resource" "kubeflow_knative_serving_manifests_priority_3" {
  for_each = data.kustomization_build.kubeflow_knative_serving.ids_prio[2]
  manifest = data.kustomization_build.kubeflow_knative_serving.manifests[each.value]

  depends_on = [
    kustomization_resource.kubeflow_knative_serving_manifests_priority_1,
    kustomization_resource.kubeflow_knative_serving_manifests_priority_2,
    kustomization_resource.kubeflow_oidc_manifests_priority_1,
    kustomization_resource.kubeflow_oidc_manifests_priority_2,
    kustomization_resource.kubeflow_oidc_manifests_priority_3,
  ]
}

resource "kustomization_resource" "kubeflow_cluster_local_gateway_manifests_priority_1" {
  for_each = data.kustomization_build.kubeflow_cluster_local_gateway.ids_prio[0]

  manifest = data.kustomization_build.kubeflow_cluster_local_gateway.manifests[each.value]

  depends_on = [
    kustomization_resource.kubeflow_knative_serving_manifests_priority_1,
    kustomization_resource.kubeflow_knative_serving_manifests_priority_2,
    kustomization_resource.kubeflow_knative_serving_manifests_priority_3
  ]
}

resource "kustomization_resource" "kubeflow_cluster_local_gateway_manifests_priority_2" {
  for_each = data.kustomization_build.kubeflow_cluster_local_gateway.ids_prio[1]
  manifest = data.kustomization_build.kubeflow_cluster_local_gateway.manifests[each.value]

  depends_on = [
    kustomization_resource.kubeflow_cluster_local_gateway_manifests_priority_1,
    kustomization_resource.kubeflow_knative_serving_manifests_priority_1,
    kustomization_resource.kubeflow_knative_serving_manifests_priority_2,
    kustomization_resource.kubeflow_knative_serving_manifests_priority_3
  ]
}

resource "kustomization_resource" "kubeflow_cluster_local_gateway_manifests_priority_3" {
  for_each = data.kustomization_build.kubeflow_cluster_local_gateway.ids_prio[2]
  manifest = data.kustomization_build.kubeflow_cluster_local_gateway.manifests[each.value]

  depends_on = [
    kustomization_resource.kubeflow_cluster_local_gateway_manifests_priority_1,
    kustomization_resource.kubeflow_cluster_local_gateway_manifests_priority_2,
    kustomization_resource.kubeflow_knative_serving_manifests_priority_1,
    kustomization_resource.kubeflow_knative_serving_manifests_priority_2,
    kustomization_resource.kubeflow_knative_serving_manifests_priority_3
  ]
}

resource "kustomization_resource" "kubeflow_knative_eventing_manifests_priority_1" {
  for_each = data.kustomization_build.kubeflow_knative_eventing.ids_prio[0]

  manifest = data.kustomization_build.kubeflow_knative_eventing.manifests[each.value]

  depends_on = [
    kustomization_resource.kubeflow_cluster_local_gateway_manifests_priority_1,
    kustomization_resource.kubeflow_cluster_local_gateway_manifests_priority_2,
    kustomization_resource.kubeflow_cluster_local_gateway_manifests_priority_3
  ]
}

resource "kustomization_resource" "kubeflow_knative_eventing_manifests_priority_2" {
  for_each = data.kustomization_build.kubeflow_knative_eventing.ids_prio[1]
  manifest = data.kustomization_build.kubeflow_knative_eventing.manifests[each.value]

  depends_on = [
    kustomization_resource.kubeflow_knative_eventing_manifests_priority_1,
    kustomization_resource.kubeflow_cluster_local_gateway_manifests_priority_1,
    kustomization_resource.kubeflow_cluster_local_gateway_manifests_priority_2,
    kustomization_resource.kubeflow_cluster_local_gateway_manifests_priority_3
  ]
}

resource "kustomization_resource" "kubeflow_knative_eventing_manifests_priority_3" {
  for_each = data.kustomization_build.kubeflow_knative_eventing.ids_prio[2]
  manifest = data.kustomization_build.kubeflow_knative_eventing.manifests[each.value]

  depends_on = [
    kustomization_resource.kubeflow_knative_eventing_manifests_priority_1,
    kustomization_resource.kubeflow_knative_eventing_manifests_priority_2,
    kustomization_resource.kubeflow_cluster_local_gateway_manifests_priority_1,
    kustomization_resource.kubeflow_cluster_local_gateway_manifests_priority_2,
    kustomization_resource.kubeflow_cluster_local_gateway_manifests_priority_3
  ]
}
