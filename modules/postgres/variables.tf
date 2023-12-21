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

variable "postgres_username" {
  type        = string
  description = "postgres administrator username"
}

variable "postgres_password" {
  type        = string
  description = "postgres administrator username"
  sensitive   = true
}

variable "postgres_sku" {
  type        = string
  description = "postgres SKU to use for the server."
}

variable "postgres_subnet_id" {
  type        = string
  description = "The ID of the subnet to which the PostgreSQL server will be connected"
}
