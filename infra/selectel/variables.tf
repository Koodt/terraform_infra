variable "api_token" {
  description = "Authorized token"
  default     = ""
}
variable "os_user_name" {
  description = "Terraform access user"
  default     = ""
}
variable "os_user_password" {
  description = "Terraform access user password"
  default     = ""
}
variable "os_project_name" {
  description = "Terraform project name"
  default     = ""
}
variable "os_auth_url" {
  description = "Selectel auth URL"
  default     = "https://api.selvpc.ru/identity/v3"
}
variable "os_domain_name" {
  description = "Selectel domain name"
  default     = ""
}
