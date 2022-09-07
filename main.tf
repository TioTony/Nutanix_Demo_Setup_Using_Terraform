/*
TH: This grabs a list of all clusters attached to the Prism Central, which includes the Prism Central itself.

Change the "0" to "1" or another number if terraform apply spits out errors saying the Cluster 
    with the UUID is not connected.  I think this happens depending on whether PC or PE comes back
    first or second but I haven't confirmed.

    This is what the error looks like:

    Error: error: {
│   "api_version": "3.1",
│   "code": 400,
│   "message_list": [
│     {
│       "message": "Given input is invalid. Referenced cluster ddbde545-2546-4f44-9c8f-c3c722d495cc is not connected",
│       "reason": "INVALID_ARGUMENT"
│     }
│   ],
│   "state": "ERROR"
│ }
│
│   with nutanix_virtual_machine.terraform-vm,
│   on main.tf line 25, in resource "nutanix_virtual_machine" "terraform-vm":
│   25: resource "nutanix_virtual_machine" "terraform-vm" {
│
╵
*/
locals {
  cluster1 = data.nutanix_clusters.clusters.entities[0].metadata.uuid
}

/*
TH: Define the location for the image to be used for creating the VM.  This image will be uploaded to the cluster by Terraform.
    This example uses the file server in PHX.  
    This same image is typically on the HPOC cluster already, but we are going to upload it again just in case it isn't there.
*/
resource "nutanix_image" "TH_TF_CentOS7" {
  name        = "TH_TF_CentOS7"
  source_uri  = "http://10.42.194.11/workshop_staging/CentOS7.qcow2"
  description = "TH_TF_CentOS7 qcow image"
}

/*
TH: This section contains the "modules" to be included for specific tasks.  Each module is a self-contained sub-directory to carry out the specific 
    creation tasks for the purpose defined in that module.  In other words, each module is an example of a specific Nutanix function that can be 
    used for demos.
*/
module "vms_in_security_policy" {
  source = "./modules/vms_in_security_policy"

  # Use the Primary Subnet
  vm_subnet = data.nutanix_subnet.Primary.id
  # Use the CentOS image created above
  vm_image = nutanix_image.TH_TF_CentOS7.id
  # Place all VMs on the cluster identified above
  vm_cluster = local.cluster1
  # Number of VMs to create
  vm_count = 10
}