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

variable "mongo_dns_id" {
  type        = string
  description = "The ID of the Private DNS zone for MongoDB."
}

variable "mongo_subnet_id" {
  type        = string
  description = "The ID of the subnet to which MongoDB will be connected."
}
