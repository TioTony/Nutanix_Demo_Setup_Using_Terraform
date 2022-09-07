Modular approach to building infrastructure for use in customer facing demos.

Most variables should be included in the terraform.tfvars file.  This should be the only file needing modification prior to use.

I have done my best to heavily document all files clearly.

Each demo scenario is fairly self-contained in a module.  Modules can be selected by commenting or uncommenting them in the main.tf file.

There is still some work to be done to meet the above goals.

Modules

vms_in_security_policy
    Create the number of VMs specified and use Flow Microsegmentation to create a security policy for these VMs

