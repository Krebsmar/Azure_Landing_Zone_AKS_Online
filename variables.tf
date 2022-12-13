### common
variable "location" {
  type    = string
  default = "westeurope"
}

### network
variable "network_resource_group_name" {
  type    = string
  default = "network"
}

variable "network_watcher_name" {
  type    = string
  default = "kubernetes_network_watcher"
}

variable "vnet_name" {
  type    = string
  default = "kubernetes"
}

variable "vnet_address_space" {
  type    = list(string)
  default = ["10.0.0.0/16"]
}

variable "bastion_name" {
  type    = string
  default = "kubernetes"
}

variable "subnet_names" {
  type    = list(string)
  default = ["gateway_subnet", "ingress_subnet", "kubernetes_subnet", "endpoint_subnet"]
}

variable "subnet_prefixes" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24", "10.0.4.0/24"]
}

### dns
variable "dns_resource_group_name" {
  type    = string
  default = "dns"
}