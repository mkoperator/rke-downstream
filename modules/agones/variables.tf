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
