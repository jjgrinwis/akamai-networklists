# a list of ips
variable "network_list" {
  description = "The list of IPs to use in our network list"
  type        = set(string)
}

variable "group_name" {
  description = "Akamai group to use this resource in"
  type        = string
}