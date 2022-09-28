/*
TH: Create a Protection Policy for the desktop systems created in this module with the following properties:

*/
resource "nutanix_protection_rule" "AMH_TF_AUTO_Protect_Desktops" {

# Name the protection rule and give it a description
name = "${var.prefix_for_created_entities}Protect_Desktops"
description = "${var.prefix_for_created_entities}Terraform created Rule to Protect Desktops"

ordered_availability_zone_list{
   /*TH: It doesn't appear there is an easy way to obtain the AZ URL programatically in Terraform.  It must 
     must be obtained using the "inspect element" from a browser open to that "Administration -> Availability Zones"
     page within Prism Central. https://nutanix.slack.com/archives/C9Z8EAS4Q/p1664301260062159
    */

   availability_zone_url = var.local_az_url
   cluster_uuid = var.vm_cluster
}

availability_zone_connectivity_list{
   snapshot_schedule_list{
      recovery_point_objective_secs = 3600
      snapshot_type= "CRASH_CONSISTENT"
      local_snapshot_retention_policy {
         num_snapshots = 2
            }
        }
}

category_filter {
   params {
      name = data.nutanix_category_key.AppTypeKey.name
      values = [ nutanix_category_value.AMH_TF_AUTO_Protection_AppType_Desktop.value ]
      }
}
}