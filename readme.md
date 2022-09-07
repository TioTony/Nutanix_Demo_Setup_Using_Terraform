
7. At the command prompt run 'terraform init'.  This will download the provider to your machine.
8. Run 'terrform plan'
9. Run 'terraform apply -auto-approve'
10. Run 'terraform destroy -auto-approve' and everthing created by Terraform will be removed.  


Modules

vms_in_security_policy
    Create the number of VMs specified and use Flow Microsegmentation to create a security policy for these VMs