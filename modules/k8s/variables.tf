variable "environment" {
  type        = string
  description = "This is the environment where the infrastructure will be deployed."
}

variable "region" {
  type        = string
  description = "This is the cloud hosting region the infrastructure will be deployed."
}

variable "region_short" {
  type        = string
  description = "This is the cloud hosting region where the infrastructure will be deployed, but shortened."
}

variable "k8s_worker_vm_size" {
  type        = string
  description = "Default VM size used for Kubernetes workers."
}

variable "k8s_subnet_id" {
  type        = string
  description = "The ID of the subnet to which the Kubernetes cluster will be connected."
}
