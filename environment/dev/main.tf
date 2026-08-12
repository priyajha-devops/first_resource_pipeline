module "resource" {
  source = "../../modules/resource"
  rgs    = var.var_rgs

}
module "storage" {
  depends_on = [module.resource]
  source     = "../../modules/storage"
  stgs       = var.var_stg

}