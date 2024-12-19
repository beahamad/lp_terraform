# Author: Ana Hamad

variable "vm_name" {
    type        = string
    description = "VM name. Required."

    validation {
        condition     = length(var.vm_name) > 0 && var.vm_name != null
        error_message = "Invalid VM name. Can not be empty, required parameter."
    }

    validation {
        condition     = can(regex("^[a-zA-Z][^$+&#<>'\"/;`%]*[^_-]$", var.vm_name))
        error_message = <<EOT
Invalid VM name.
    Can not start with numbers, - or _
    Can not contain special characters, except - and _
    Can not end with - or _
EOT
    }
}

variable "vm_count" {
    type        = number
    default     = 1
    description = "Number of VMs to be created. Default: 1."

    validation {
        condition     = var.vm_count > 0
        error_message = "Invalid quantity. Can not be 0 or less."
    }
}

variable "vm_image" {
    type        = string
    default     = "https://app.vagrantup.com/ubuntu/boxes/bionic64/versions/20180903.0.0/providers/virtualbox.box"
    description = "VM image. Default: Ubuntu."
}

variable "vm_size" {
    type        = string
    default     = "micro" 
    description = "VM size by amount of resources allocated."

    validation {
      condition = contains(["micro", "small", "medium", "large"], var.vm_size)
      error_message = <<EOT
Invalid size.
Allowed values: 
    - micro (1Gb mem, 1 vCPU)
    - small (2Gb mem, 2 vCPU)
    - medium (4Gb mem, 4 vCPU)
    - large (6Gb mem, 4 vCPU)
Default: micro
EOT
    }
}

variable "setup" {
  default = {
    "micro"   = {
      vm_mem  = "1024mib",
      vm_cpus = 1,
      max     = 12
    }
    "small"   = {
      vm_mem  = "2048mib",
      vm_cpus = 2,
      max     = 6
    }
    "medium"  = {
      vm_mem  = "4096mib",
      vm_cpus = 4,
      max     = 3
    }
    "large"   = {
      vm_mem  = "6144mib",
      vm_cpus = 4,
      max     = 2
    }
  }
}

variable "net_type" {
    type        = string
    default     = "hostonly"
    description = "Type of the network adapter to be configured. Default: hostonly."

    validation {
      condition = contains(["nat", "bridged", "hostonly", "internal", "generic"], var.net_type)
      error_message = <<EOT
Invalid network adapter.
Allowed values:
    - nat
    - bridged
    - hostonly
    - internal
    - generic
Default: hostonly
EOT
    }
}