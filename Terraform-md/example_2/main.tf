variable "lab_prefix"       { default = "nginx" }

locals {
  rg = {                    # Resource group
    name                    = format("%s-rg", var.lab_prefix)
    location                = "westus2"
  }
  vnet = {                  # virtual networks
    name                    = format("%s-bigip", var.lab_prefix)
    cidr                    = "10.210.0.0/16"
  }
  nsg = {                   # Network security group
    name                    = format("%s-nsg", var.lab_prefix)
    src_addrs               = ["24.16.243.5","173.59.5.20","20.42.154.161", "67.168.116.128"]
    src_addrs               = ["10.1.0.0/16", "172.17.0.0/16", "192.168.0.0/24"]
    dst_ports               = ["22","443", "8443"]
  }
  log_analytics = {         # Log Analytics Workspace
    name                    = format("%s-law", var.lab_prefix)
    retention               = "30"
    sku                     = "PerNode"
    ts_region               = "us-west-2"
    ts_type                 = "Azure_Log_Analytics"
    ts_log_group            = "f5telemetry"
    ts_log_stream           = "default"
  }
  lb = {                    # load-balancer
    use_lb                  = 1
    name                    = format("%s-lb", var.lab_prefix)
    pool_name               = format("%s-lb_pool", var.lab_prefix)
    sku                     = "Standard"
    priv_allocation         = "Dynamic"
    priv_version            = "IPv4"
  }
}


output "rg"   { value = local.rg}
output "vnet" { value = local.vnet}
output "nsg"  { value = local.nsg}
output "law"  { value = local.log_analytics }
output "lb"   { value = local.lb }
