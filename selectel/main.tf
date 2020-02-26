provider "selectel" {
  token = var.api_token
}

resource "selectel_vpc_user_v2" "selectel_user" {
  name     = var.user_name
  password = var.user_pass
  enabled  = true
}
