# About

Modular approach to building infrastructure for use in customer facing demos.

Most variables should be included in the terraform.tfvars file.  This should be the only file needing modification prior to use.

I have done my best to heavily document all files clearly.

Each demo scenario is fairly self-contained in a module.  Modules can be selected by commenting or uncommenting them in the main.tf file.

There is still some work to be done to meet the above goals.

## Cluster setup

- These scripts are deisgned to work with any HPOC system regardless of location

- Prism Central is required.

- PHX Clusters will currently be a bit quicker as the OS Image being used is located on the PHX file server

- Specific modules in this terraform script require a Prism Central with 2 Clusters attached. Review the module list to determine if 1 or 2 clusters are needed based on the planned module usage.

- Clusters can be any number of nodes (1, 2, 3, 4 or more). 

- Clusters do not need to be in the same location for modules requiring 2 clusters.

- Prequisites can be configured through HPOC runbooks or manually, it doesn't matter as long as they exist and are enabled.

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
- Create the number of VMs specified and use Flow Microsegmentation to create a security policy for these VMs.
- Prerequisites: Flow or Security Policy Microsegmentation must be enabled.  Works with any number of clusters. Microsegentation can be enabled by going to Prism Central -> Network & Security -> Security Policies -> Enable. 

### vms_in_leap_protection_policy
- Create the number of VMs specified and implement a Leap Protection Policy
- Prerequisites: This module requires 2 Clusters be registered to the Prism Central.  Disaster Recovery for the Local AZ must be enabled must be enabled.  This can be done by going to Prism Central -> Data Protection -> Protection Policies -> Create Protection Policy and clicking enable in the title banner. The Create Protection Policy workflow can then be cancelled. 

### Tested Versions

| Nutanix Provider Version | AOS Version | PC Version | Date Tested |
|----------|----------|----------|----------|
| 1.7.0 | 5.20.3 | pc.2022.6 | 9/20/2022 |
| 1.7.0 | 6.5 | pc.2022.6 | 9/21/2022 |
| 1.7.1 | 6.5.1 | pc.2022.6 | 9/28/2022 |

