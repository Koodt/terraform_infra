output "terraform_user_id" {
  value = selectel_vpc_user_v2.selectel_user.id
  description = "Terraform user id"
}

output "terraform_user_name" {
  value = selectel_vpc_user_v2.selectel_user.name
  description = "Terraform user name"
}

output "terraform_user_password" {
  value = selectel_vpc_user_v2.selectel_user.password
  description = "Terraform user password"
}

output "terraform_project_id" {
  value = selectel_vpc_project_v2.terraform_project.id
  description = "Terraform project id"
}
