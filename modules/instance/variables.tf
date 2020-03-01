variable "hostname" {}
variable "key_pair" {}
variable "volume_type" {
  default = ""
}
variable "server_az" {}
variable "volume_size" {
  default = 0
}
variable "flavor_id" {}
variable "image" {
  default = "Ubuntu 18.04 LTS 64-bit"
}
variable "first_ip_subnet" {}
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
variable "instance_numbers" {
  default = 1
}
variable "name" {}
