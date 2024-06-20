variable "PM_API_URL" {
  type    = string
  default = "https://10.10.10.111:8006/api2/json"
}

variable "PM_USER" {
  type    = string
  default = "terraform-prov@pve"
}

variable "PM_PASS" {
  type    = string
  default = "29Kv%&acuWvM3eMb"
}

# variable "interface" {
#   type = string
#   default = <<EOF1
#   network:
#   ethernets:
#     ens18:
#       addresses:
#       - 10.10.10.81/24
#       nameservers:
#         addresses:
#         - 10.10.10.220
#         - 8.8.8.8
#         search:
#         - karam.lab
#       routes:
#       - to: default
#         via: 10.10.10.1
#   version: 2
#   EOF
#   }
