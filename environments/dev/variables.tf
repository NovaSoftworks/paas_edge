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

variable "default_sku" {
  type        = string
  description = "Default SKU used for virtual machines."
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
