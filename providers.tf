provider "kustomization" {
  kubeconfig_raw = module.multiarch-k8s.kubernetes_kubeconfig
}
