variable "prefix" {
  default = "ProjectName"
}

locals {
  rg_name = "${var.prefix}-RG"
}

resource "null_resource" "call_echo" {
  provisioner "local-exec" {
    command = "echo \"The object prefix is ${var.prefix} and the rg_name is ${local.rg_name}\""
  }
}

output "prefix_name" {
  value = var.prefix
}

output "object_name" {
  value = local.rg_name
}
