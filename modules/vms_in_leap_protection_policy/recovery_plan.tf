/*
TH: Create a Recovery Plan for the desktop systems created in this module with the following properties:
   - Single Stage
   - Fails over all VMs in the Protection Policy 
*/
# Name the recovery plan and give it a description

resource "nutanix_recovery_plan" "AMH_TF_AUTO_Recovery_Plan_Desktops" {
    name        = "${var.prefix_for_created_entities}Recovery_Plan_Desktops"
    description = "${var.prefix_for_created_entities}Terraform created Recovery Plan for Desktops"

# Define the entities in the stage.
    stage_list {
        stage_work{
            recover_entities{
                entity_info_list{
                    # Use the same category that was used for the protection policy.
                    categories {
                        name = data.nutanix_category_key.AppTypeKey.name
                        value = nutanix_category_value.AMH_TF_AUTO_Protection_AppType_Desktop.value
                    }
                }
            }
        }
    }


    parameters{
        network_mapping_list{
            availability_zone_network_mapping_list{
                availability_zone_url = var.prism_central
                cluster_reference_list {
                    kind = "cluster"
                    uuid = var.source_cluster
                }

                recovery_network {
                    name = "Primary"
                }

                test_network {
                    name = "Primary"
                }
            }
        }

        network_mapping_list{
            availability_zone_network_mapping_list{
                availability_zone_url = var.prism_central

                cluster_reference_list {
                    kind = "cluster"
                    uuid = var.destination_cluster
                }

                recovery_network {
                    name = "Primary"
                }

                test_network {
                    name = "Primary"
                }
            }
        }
    }
}
