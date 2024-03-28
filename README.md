# linode-terraform-allregions
 
Simple shell script that does the following-

* Uses the Linode API to scan for all current available Linode regions.
* Automates provisioning via Terraform to create a virtual machine in each available region.
* Outputs the IP addresses of the new virtual machines to an Ansible inventory file.

To use, the Linode API must be installed and configured on the host machine, and the Linode token for Terraform should be stored in a "LINODE_TOKEN" env variable. 

I built this to facilitate easier deployment and testing of massively distributed applications that will need to run in each Linode or Akamai Compute region. 
