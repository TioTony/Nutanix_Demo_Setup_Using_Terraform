# About

Modular approach to building infrastructure for use in customer facing demos.

Most variables should be included in the terraform.tfvars file.  This should be the only file needing modification prior to use.

I have done my best to heavily document all files clearly.

Each demo scenario is fairly self-contained in a module.  Modules can be selected by commenting or uncommenting them in the main.tf file.

There is still some work to be done to meet the above goals.

## Cluster setup
- These scripts expect a Prism Central with 2 Clusters attached.  The first cluster can be a 1,3 or 4 node cluster from the PHX HPOC.  This cluster will host the Prism Central.  

- PHX should be used for the first cluster because the images being referenced are on the PHX file server.

- The second cluster can be in any HPOC location and can also be a 1, 3 or 4 node cluster.  PHX and DM3 have been verified.  AWS will be tested soon.

- Flow (Security Policy Microsegmentation) must be eneabled.

- Disaster Recovery for the Local AZ must be enabled in Leap.  This can be done by manually creating a Protection Policy in Prism Central and selecting "Enable" on the title bar that appears.  The creation of the policy can then be canceled. 

## Use
- Visual Studio Code was used to create this code but you can use whatever fits your needs
- Visit the Terraform site for Terraform installation instruactions.  They cover it better than I could.
- Update the terraform.tfvars file with the Nutanix Cluster information
- This isn't a Terraform tutorial, but here are the basic commands needed to use this code
    - terraform init
    - terraform get 
    - terraform plan
    - terraform apply -auto-approve
    - terraform destroy -auto-approve

- All VMs will be created in the cluster identified in by the Index value in main.tf and datasources.tf.  The other cluster will be
  a destination target for Protection Policies, VPCs, etc.

## Modules

### vms_in_security_policy
    Create the number of VMs specified and use Flow Microsegmentation to create a security policy for these VMs

### vms_in_leap_protection_policy
    Create the number of VMs specified and implement a Leap Protection Policy

    Note: This modele requires 2 Clusters be registered to the Prism Central 
    Note: The Availability Zone URL must be obtained from the Prism Central UI.  See notes in terraform.tfvars

### Tested Versions

| Nutanix Provider Version | AOS Version | PC Version | Date Tested |
|----------|----------|----------|----------|
| 1.7.0 | 5.20.3 | pc.2022.6 | 9/20/2022 |
| 1.7.0 | 6.5 | pc.2022.6 | 9/21/2022 |
| 1.7.1 | 6.5.1 | pc.2022.6 | 9/28/2022 |

