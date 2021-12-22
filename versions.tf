terraform {
  required_providers {
    metal = {
      source  = "equinix/metal"
      version = ">=2.1.0"
    }

    kustomization = {
      source  = "kbst/kustomization"
      version = "0.7.0"
    }

    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "1.13.1"
    }

    helm = {
      source = "hashicorp/helm"
      version = "2.4.1"
    }

    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.7.1"
    }
  }

  required_version = ">= 1.0.0"
}

