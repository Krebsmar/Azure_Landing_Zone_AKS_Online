variable "location" {
  type = string
  default = "West Europe"
}

variable "network_resource_group_name" {}

variable "k8s_vnet_name" {
  type = string
  default = "k8s_vnet"
}

variable "k8s_vnet_address_space" {
  type    = list(string)
  default = [10.0.0.0/16]
}

variable "gateway_subnet_name" {
  type    = string
  default = "gateway_subnet"
}

variable "gateway_subnet_address_prefixes" {
  type    = list(string)
  default = [10.0.1.0/24]
}
variable "ingress_subnet_name" {
  type    = string
  default = "ingress_subnet"
}

variable "ingress_subnet_address_prefixes" {
  type    = list(string)
  default = [10.0.2.0/24]
}

variable "k8s_subnet_name" {
  type    = string
  default = "k8s_subnet"
}

variable "k8s_subnet_address_prefixes" {
  type    = list(string)
  default = [10.0.3.0/24]
}
variable "endpoint_subnet_name" {
  type    = string
  default = "endpoint_subnet"
}

variable "endpoint_subnet_address_prefixes" {
  type    = list(string)
  default = [10.0.4.0/24]
}

