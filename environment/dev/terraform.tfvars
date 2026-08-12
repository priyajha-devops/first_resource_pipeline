var_rgs = {
  r1 = {
    name     = "rg_planet"
    location = "centralindia"
  }
  r2 = {
    name     = "rg_universe"
    location = "westus"
  }
  r3 = {
    name     = "rg_sun"
    location = "westus"
  }


}
var_stg = {
  s1 = {
    name                     = "storagexyz7352"
    location                 = "centralindia"
    resource_group_name      = "rg_planet"
    account_replication_type = "LRS"
    account_tier             = "Standard"
  }
  s2 = {
    name                     = "storagepqr7352"
    location                 = "westus"
    resource_group_name      = "rg_universe"
    account_replication_type = "LRS"
    account_tier             = "Standard"
  }
}