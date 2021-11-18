module "multiarch-k8s" {
  # source  = "/Users/keith/Projects/terraform-metal-multiarch-k8s"
  source  = "equinix/multiarch-k8s/metal" # not the correct version; use a local version until equinix publishes a new one
  version = "0.3.0"

  auth_token = var.auth_token
  metal_create_project = false
  project_id = var.project_id
  facility = var.facility
  count_arm = var.count_arm
  count_x86 = var.count_x86
  ccm_enabled = true
}

