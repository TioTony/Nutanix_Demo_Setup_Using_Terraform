/*
TH: Create a policy for the desktop systems craeted in this module with the following properties:
    - VMs are in the same AppTier but cannot communicate with each other
    - VMs allow all outbound traffic
    - VMs allow inbound traffic on ports 22, 80, and 443
*/
resource "nutanix_network_security_rule" "TH_TF_Secure_Desktops" {

# Name the rule and give it a description
name = "TH_TF_Secure_Desktops"
description = "TH Terraform created Rule to Secure Desktops"

# Set applicatoin rule mode
app_rule_action = "MONITOR"

# Rules for Desktops
app_rule_target_group_peer_specification_type = "FILTER"
app_rule_target_group_default_internal_policy = "DENY_ALL"
app_rule_target_group_filter_type = "CATEGORIES_MATCH_ALL"
app_rule_target_group_filter_kind_list = [ "vm" ]

# === Rule will be applyed to ===
app_rule_target_group_filter_params {
   name = data.nutanix_category_key.AppTypeKey.name
   values = [ nutanix_category_value.TH_TF_Secure_AppType_Desktop.value ]
}
app_rule_target_group_filter_params {
   name = data.nutanix_category_key.AppTierKey.name
   values = [ nutanix_category_value.TH_TF_Secure_AppTier_Desktop.value ]
}

 # === Inbound traffic rule ===
app_rule_inbound_allow_list {
   ip_subnet               = "0.0.0.0"
   ip_subnet_prefix_length = "0"
   peer_specification_type = "IP_SUBNET"
   protocol                = "TCP"
   tcp_port_range_list {
      end_port   = 80
      start_port = 80
   }
   tcp_port_range_list {
      end_port   = 443
      start_port = 443
   }
}

# === Outbound traffic rule ===
app_rule_outbound_allow_list {
    ip_subnet               = "0.0.0.0"
    ip_subnet_prefix_length = "0"
    peer_specification_type = "IP_SUBNET"
    protocol                = "TCP"
    tcp_port_range_list {
      end_port   = 80
      start_port = 80
    }
    tcp_port_range_list {
      end_port   = 443
      start_port = 443
    }
  }
}