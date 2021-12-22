variable "auth_token" {
  description = "Auth Token for Equinix Metal"
  type        = string
}

variable "project_id" {
  description = "Project ID to create equinix infra"
  type        = string
}

variable "facility" {
  description = "Facility in which to create infra"
  type        = string
  default     = ""
}

variable "metro" {
  description = "Metro in which to create infra"
  type        = string
  default     = ""
}

variable "count_arm" {
  type        = number
  description = "Number of ARM nodes."
}

variable "count_x86" {
  type        = number
  description = "Number of x86 nodes."
}

variable "kubeflow_version" {
  type        = string
  description = "Version of kubeflow to install"
  default     = "1.4.0"
}