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

variable "jumpbox_vm_size" {
  type        = string
  description = "Default VM size used for the Jumpbox."
}

variable "jumpbox_username" {
  type        = string
  description = "Jumpbox administrator username"
}

variable "jumpbox_password" {
  type        = string
  description = "Jumpbox administrator password"
  sensitive   = true
}

variable "postgres_vm_size" {
  type        = string
  description = "Default VM size used for PostgreSQL."
}

variable "postgres_username" {
  type        = string
  description = "PostgreSQL administrator username"
}

variable "postgres_password" {
  type        = string
  description = "PostgreSQL administrator password"
  sensitive   = true
}

variable "k8s_sku_tier" {
  type        = string
  description = "Default SKU tier for Kubernetes cluster management."
}

variable "k8s_vm_size" {
  type        = string
  description = "Default VM size used for Kubernetes workers."
}

variable "k8s_node_count" {
  type        = string
  description = "How many worker nodes to use for Kubernetes."
}
