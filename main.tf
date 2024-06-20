terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "3.0.1-rc3"
    }
  }
}

provider "proxmox" {
  # pm_log_enable = true
  # pm_log_file   = "./terraform-plugin-proxmox.log"
  # pm_debug      = true
  # pm_log_levels = {
  #   _default    = "debug"
  #   _capturelog = ""
  # }
  pm_api_url      = var.PM_API_URL
  pm_tls_insecure = true
  pm_user         = var.PM_USER
  pm_password     = var.PM_PASS
}


# locals {
#   vm_name          = "pxsw05"
#   pve_node         = "px01"
#   iso_storage_pool = "local"
# }

# resource "proxmox_cloud_init_disk" "ci" {
#   name      = local.vm_name
#   pve_node  = local.pve_node
#   storage   = local.iso_storage_pool

#   meta_data = yamlencode({
#     instance_id    = sha1(local.vm_name)
#     local-hostname = local.vm_name
#   })

# #   user_data = <<EOT
# # #cloud-config
# # users:
# #   - default
# # ssh_authorized_keys:
# #   - ssh-rsa AAAAB3N......
# # EOT

#   network_config = yamlencode({
#     version = 1
#     config = [{
#       # type = "physical"
#       name = "ens18"
#       subnets = [{
#         type            = "static"
#         address         = "10.10.10.85/24"
#         gateway         = "10.10.10.1"
#         dns_nameservers = ["1.1.1.1", "8.8.8.8"]
#       }]
#     }]
#   })
# }


resource "proxmox_vm_qemu" "swarm-vm" {
  name        = "pxsw05"
  target_node = "px01"
  # pxe = false
  ### Clone VM operation
  clone      = "pxsw00"
  full_clone = true
  # boot       = "order=ide2;scsi0"
  boot       = "order=scsi0"
  # bootdisk = "scsi0"
  memory     = "8192"
  sockets    = "4"
  cores      = "2"
  cpu        = "host"
  # # pool = "local-lvm"
  searchdomain = "karam.lab"
  nameserver   = "10.10.10.220"
  ipconfig0    = "ip=10.10.10.55/24,gw=10.10.10.1"
  skip_ipv6    = true
  network {
    model    = "virtio"
    bridge   = "vmbr0"
    firewall = false
    mtu      = "9000"
  }

  scsihw  = "virtio-scsi-pci"
  # onboot = true
  # startup = "order=2"
  disks {
    # ide {
    #   ide2 {
    #     cdrom {
    #       iso = "${local.iso_storage_pool}:${proxmox_cloud_init_disk.ci.id}"
    #       # iso = "${local.iso_storage_pool}:bionic-server-cloudimg-amd64.img"
    #     }
    #   }
    # }
    scsi {
      scsi0 {
        disk {
          backup  = true
          # id      = "0"
          size    = "80G"
          storage = "local-lvm"
        }
      }
    }
  }
  os_type   = "ubuntu"
  # define_connection_info = true
  # os_network_config = var.interface
  # ssh_forward_ip = "10.10.10.85"

  # provisioner "remote-exec" {
  #   inline = [
  #     "ip a"
  #   ]
  # }


}


# resource "proxmox_vm_qemu" "pxsw01" {
#   # (resource arguments)
# }
