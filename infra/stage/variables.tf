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
variable "os_region" {
  description = "Selectel project region"
  default     = ""
}
variable "isolate_network_name" {
  description = "Isolate private network name"
  default     = "isolate_private_network"
}
variable "isolate_network_CIDR" {
  description = "Isolate private network CIDR"
  default     = "192.168.0.0/24"
}
