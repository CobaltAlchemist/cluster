output "master_ip" {
  value = proxmox_vm_qemu.k3s_master[*].ip
}

output "worker_ips" {
  value = proxmox_vm_qemu.k3s_worker[*].ip
}