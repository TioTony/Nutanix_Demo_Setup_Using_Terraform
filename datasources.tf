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
*/

data "nutanix_subnet" "Primary" {
  subnet_name = "Primary"
  
  additional_filter {
  name = "name"
  values = ["Primary"]
  }

  additional_filter {
  name = "cluster_reference.uuid"
  values = ["${data.nutanix_clusters.clusters.entities[0].metadata.uuid}"]
  }
}