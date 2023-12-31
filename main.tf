resource "proxmox_vm_qemu" "k3s_master" {
  count       = 1
  name        = "k3s-master"
  target_node = "marie"

  clone       = var.vm_template
  full_clone  = true

  cores       = var.master_vm_cpu
  memory      = var.master_vm_ram
  storage     = var.vm_storage

  # Additional configurations like network, etc.
}

resource "proxmox_vm_qemu" "k3s" {
    for_each = {
        for vm in vars.k3svms : vm.name => vm 
    }

    name        = each.value.name
    target_node = each.value.target_node

  # Define common configurations like network settings, disk size, etc.
    os_type     = "cloud-init"
    clone       = "ubuntu-22.04-server-cloudimg-amd64"
    full_clone  = true

    cores        = var.worker_vm_cpu  # Set default core count
    memory       = var.worker_vm_ram  # Set default memory size in MB
    agent        = 1
    disk {
        size = "20G"
        type = "virtio"
        storage = "zfs-storage"
    }
    network {
        model = "virtio"
        bridge = "vmbr0"
    }
    lifecycle {
        ignore_changes = [
            target_node,
            network,
            clone,
            full_clone,
            qemu_os
        ]
    }
}
