#  Copyright (c) Juniper Networks, Inc., 2025-2025.
#  All rights reserved.
#  SPDX-License-Identifier: MIT

locals {
  template_text = <<-EOT
  vlans {
      disabled_vlan {
          vlan-id %d;
      }
  }

  {%% for int, int_info in interface.items() %%}
  {%% if int_info.role == "unused" %%}
  interfaces {
    replace: {{ int_info.intfName }} {
      disable;
      unit 0 {
        family ethernet-switching {
          interface-mode access;
          vlan {
            members disabled_vlan;
          }
        }
      }
    }
  }
  {%% endif %%}
  {%% endfor %%}
  EOT
}

resource "apstra_datacenter_configlet" "a" {
  blueprint_id = var.blueprint_id
  name         = var.name
  condition = "role in [\"superspine\", \"spine\", \"leaf\", \"access\"]"
  generators = [
    {
      config_style  = "junos"
      section       = "top_level_hierarchical"
      template_text = format(local.template_text, var.unused_interface_vlan)
    },
  ]
}
