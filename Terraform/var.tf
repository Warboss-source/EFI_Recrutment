variable "resource_group_name" {
  description = "Azure resource group name"
  type        = string
}

variable "location" {
  description = "Azure location"
  type        = string
  default     = "polandcentral"
}

variable "admin_username" {
  description = "Admin username for VMs"
  type        = string
  default     = "warboss"
}

variable "ssh_public_key_path" {
  description = "Path to your public SSH key"
  type        = string
}

variable "vm_size" {
    description = "Size of VM"
    type = string
}