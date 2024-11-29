variable "vm_name" {
    type        = string
    description = "VM name. Required."

    validation {
        condition     = length(var.vm_name) > 0 && var.vm_name != null
        error_message = "Invalid VM name. Can not be empty, required parameter."
    }

    validation {
        condition     = can(regex("^[a-zA-Z][^$+&#<>'\"/;`%]*[^_-]$"))
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
    description = <<EOF
VM size by amount of resources allocated.
Allowed values: 
    - micro (1Gb mem, 1 vCPU)
    - small (4Gb mem, 2 vCPU)
    - medium (4Gb mem, 4 vCPU)
    - large (6Gb mem, 4 vCPU)
Default: micro
EOF
}

variable "vm_memory" {
    type = string
    default = "1024mib"
    description = "VM memory allocated. Default: 1024mib (micro)"
}

variable "vm_cpus" {
    type        = number
    default     = 1
    description = "Number of vCPUs. Default: 1"
}

variable "network_type" {
    type        = string
    default     = "hostonly"
    description = "Type of the network adapter to be configured. Default: hostonly."

    validation {
      condition = contains(["nat", "bridged", "hostonly", "internal", "generic"], var.network_type)
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