resource "selectel_vpc_user_v2" "selectel_user" {
  name     = var.user_name
  password = var.user_pass
  enabled  = true
}

resource "selectel_vpc_project_v2" "terraform_project" {
  name        = var.project_name
  auto_quotas = true
}

resource "selectel_vpc_role_v2" "terraform_role" {
  project_id = selectel_vpc_project_v2.terraform_project.id
  user_id    = selectel_vpc_user_v2.selectel_user.id
}
