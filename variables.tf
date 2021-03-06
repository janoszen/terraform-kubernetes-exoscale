variable "exoscale_key" {
  description = "Exoscale API key"
}
variable "exoscale_secret" {
  description = "Exoscale API secret"
}

variable "service_domain" {
  description = "Service domain name to use for the Kubernetes cluster"
}

variable "service_domain_zone" {
  description = "DNS zone on Exoscale DNS to use for the Kubernetes cluster"
}

variable "exoscale_zone" {
  description = "Exoscale zone (lower case)"
  default = "at-vie-1"
}

variable "firewall_allowed_ssh" {
  description = "Allowed IP ranges for SSH access"
  type = list(string)
  default = ["0.0.0.0/0"]
}

variable "firewall_allowed_k8s" {
  description = "Allowed IP ranges for Kubernetes API access"
  type = list(string)
  default = ["0.0.0.0/0"]
}

variable "ssh_port" {
  description = "SSH port to use for servers. Do not set to 22."
  default = 12222
  type = number
}

variable "k8s_port" {
  description = "Kubernetes API port."
  default = 6443
  type = number
}

variable "k8s_healthcheck_port" {
  description = "Kubernetes healthcheck port."
  default = 6080
  type = number
}

variable "ingress_allowed_tcp_ports" {
  description = "TCP ports allowed for ingress"
  type = list(number)
  default = [80,443]
}

variable "ingress_allowed_udp_ports" {
  description = "UDP ports allowed for ingress"
  type = list(number)
  default = []
}

variable "server_admin_users" {
  description = "Server admin users and their SSH key"
  type = map(string)
  default = {}
}

variable "workers" {
  description = "Worker nodes to provision"
  default = 3
}

variable "prefix" {
  description = "Resource prefix"
  default = "k8s"
}

variable "terraform_os" {
  description = "The OS Terraform is running on (windows, linux or darwin)"
  default = "windows"
}

locals {
  kubernetes_version = "1.15.3"
  containerd_version = "1.3.4"
  critools_version = "1.18.0"
  runc_version = "1.0.0-rc10"
  cni_plugins_version = "0.8.6"
}

locals {
  service_domain_stub = var.service_domain == var.service_domain_zone?"@":"${replace(var.service_domain, ".${var.service_domain_zone}", "")}"
  service_domain_suffix = var.service_domain == var.service_domain_zone?"":".${replace(var.service_domain, ".${var.service_domain_zone}", "")}"
}