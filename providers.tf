provider "kustomization" {
  kubeconfig_raw = module.multiarch-k8s.kubernetes_kubeconfig
}

provider "kubectl" {
  config_path = module.multiarch-k8s.kubernetes_kubeconfig_file
}

provider "helm" {
  kubernetes {
    config_path = module.multiarch-k8s.kubernetes_kubeconfig_file
  }
}

provider "kubernetes" {
  config_path = module.multiarch-k8s.kubernetes_kubeconfig_file
}