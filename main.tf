terraform {
  required_providers {
    proxmox = {
      source = "Telmate/proxmox"
      version = "3.0.1-rc3"
    }
  }
}

provider "proxmox" {
  pm_api_url = "http://10.10.10.110:8006/api2/json"
  # pm_user = var.PM_USER
  # pm_password = var.PM_PASS
  pm_user = "terraform@pve"
  pm_password = "29Kv%&acuWvM3eMb"
}
