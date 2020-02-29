variable "hostname" {}
variable "fqdn" {}
variable "key_pair" {}
variable "volume_type" {
  default = ""
}
variable "server_az" {}
variable "volume_size" {
  default = ""
}
variable "flavor_id" {}
variable "image_id" {}
variable "first_ip" {}
variable "first_network_id" {}
variable "first_network_subnet_id" {}
variable "second_ip" {
  default = ""
}
variable "second_network_id" {
  default = ""
}
variable "second_network_subnet_id" {
  default = ""
}
