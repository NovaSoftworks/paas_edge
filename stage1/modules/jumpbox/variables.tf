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

variable "jumpbox_username" {
  type        = string
  description = "Jumpbox administrator username."
}

variable "jumpbox_password" {
  type        = string
  description = "Jumpbox administrator password."
  sensitive   = true
}

variable "jumpbox_vm_size" {
  type        = string
  description = "Default VM size used for the Jumpbox."
}

variable "jumpbox_subnet_id" {
  type        = string
  description = "The ID of the subnet to which the Jumpbox will be connected."
}
