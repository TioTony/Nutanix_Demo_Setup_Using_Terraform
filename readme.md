# About

Modular approach to building infrastructure for use in customer facing demos.

Most variables should be included in the terraform.tfvars file.  This should be the only file needing modification prior to use.

I have done my best to heavily document all files clearly.

Each demo scenario is fairly self-contained in a module.  Modules can be selected by commenting or uncommenting them in the main.tf file.

There is still some work to be done to meet the above goals.

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

## Modules

**vms_in_security_policy**
    Create the number of VMs specified and use Flow Microsegmentation to create a security policy for these VMs

**vms_in_leap_protection_policy**
    Create the number of VMs specified and implement a Leap Protection Policy

    Note:  This modele requires 2 Clusters be registered to the Prism Central 

