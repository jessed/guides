output "rg" {
  description = "Resource group details"
  value = {
    rg_name     = module.rg.*.out.name
    rg_location = module.rg.*.out.location
    rg_id       = module.rg.*.out.id
  }
}
