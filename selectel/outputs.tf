output "Terraform_user" {
  value = selectel_vpc_user_v2.selectel_user.name
  description = "Terraform access user"
}

output "Terraform_user_pass" {
  value = selectel_vpc_user_v2.selectel_user.password
  description = "Terraform access user"
}
