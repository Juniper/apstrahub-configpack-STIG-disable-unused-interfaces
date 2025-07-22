#  Copyright (c) Juniper Networks, Inc., 2025-2025.
#  All rights reserved.
#  SPDX-License-Identifier: MIT

variable "name" {
  type = string
  default = "Disable Unused Interfaces"
}

variable "blueprint_id" {
  type = string
}

variable "unused_interface_vlan" {
  type = number
  description = "VLAN to assign to unused interfaces"
}
