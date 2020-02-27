output "Terraform_user_id" {
  value = selectel_vpc_user_v2.selectel_user.id
  description = "Terraform user id"
}

output "Terraform_project_id" {
  value = selectel_vpc_project_v2.terraform_project.id
  description = "Terraform project id"
}
