# Required
variable "kubeconfig_file" {
  type        = string
  description = "cluster config file"
}
# Required
variable "project_id" {
  type        = string
  description = "id of agones project"
}
variable "values_yaml" {
  type        = string
  description = "values file name"
  default     = "values.yaml"  
}