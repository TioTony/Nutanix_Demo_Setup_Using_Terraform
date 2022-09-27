/*
TH: Create a data source for Nutanix Clusters
*/
data "nutanix_clusters" "clusters" {
}

/*
TH: Create a data source for the "Primary" subnet that exists on all HPOCS
    The Filters ensure the "Primary" subnet for the cluster used throughtout
    these scripts is used.  This prevents confusion if 2 or more HPOC 
    clusters are attached to the same PC as there will be more than 1 "Primary"
    subnet avaialble since each HPOC system will have its own "Primary" subnet.

Change the "0" to "1" or another number if terraform apply spits out errors saying the "subnet with the given nam, not found".
  I think this happens depending on whether PC or PE comes back first or second but I haven't confirmed.  This appears to be
  the same issue noted in main.tf but the error is different.  The index number for the cluster filter in this section
  should be the same as the index used in main.tf.

    This is what the error looks like:

    ╷
│ Error: subnet with the given name, not found
│
│   with data.nutanix_subnet.Primary,
│   on datasources.tf line 15, in data "nutanix_subnet" "Primary":
│   15: data "nutanix_subnet" "Primary" {
│
*/

data "nutanix_subnet" "Primary" {
  subnet_name = "Primary"

  /*
  additional_filter {
  name = "name"
  values = ["Primary"]
  }
  */

  additional_filter {
    name   = "cluster_reference.uuid"
    values = ["${data.nutanix_clusters.clusters.entities[1].metadata.uuid}"]
  }
}