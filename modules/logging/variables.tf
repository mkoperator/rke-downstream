# Required
variable "kubeconfig_file" {
  type        = string
  description = "cluster config file"
}
# Required
variable "project_system_id" {
  type        = string
  description = "id of system project"
}
variable "values_yaml" {
  type        = string
  description = "values file name"
  default     = "values.yaml"  
}