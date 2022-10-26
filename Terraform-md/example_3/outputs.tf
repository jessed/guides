output "rg1" {
  description = "Resource group details"
  value = {
    rg_name     = module.rg1.out.name
    rg_location = module.rg1.out.location
    rg_id       = module.rg1.out.id
  }
}

output "rg2" {
  description = "Resource group details"
  value = {
    rg_name     = module.rg2.out.name
    rg_location = module.rg2.out.location
    rg_id       = module.rg2.out.id
  }
}
