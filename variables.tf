# Description: Terraform variables for the project
# Type: Terraform variables
variable "pm_api_url" {}
variable "pm_user" {}
variable "pm_password" {}

variable "vm_template" {
  description = "Template for the VMs"
}

variable "vm_storage" {
  description = "Storage for the VMs"
}

variable "master_vm_cpu" {
  description = "Number of CPUs for the master VM"
  default     = 4
}

variable "master_vm_ram" {
  description = "RAM for the master VM in GB"
  default     = 8192
}

variable "worker_vm_cpu" {
  description = "Number of CPUs for each worker VM"
  default     = 2
}

variable "worker_vm_ram" {
  description = "RAM for each worker VM in GB"
  default     = 4096
}

variable "k3s_workers" {
  description = "List of k3s worker VM configurations"
  type = list(object({
    name        = string
    target_node = string
    # Add other necessary attributes like cores, memory, etc.
  }))
  default = []
}