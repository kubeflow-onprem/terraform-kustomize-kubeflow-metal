variable "auth_token" {
  description = "Auth Token for Equinix Metal"
  type = string
}

variable "project_id" {
  description = "Project ID to create equinix infra"
  type = string
}

variable "facility" {
  description = "Facility in which to create infra"
  type = string
}

variable "count_arm" {
  type        = number
  description = "Number of ARM nodes."
}

variable "count_x86" {
  type        = number
  description = "Number of x86 nodes."
}