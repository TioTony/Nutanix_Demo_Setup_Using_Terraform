/*
TH: Create a data source for Nutanix Clusters
*/
data "nutanix_clusters" "clusters" {
}

/*
TH: Create a data source for the "Primary" subnet that exists on all HPOCS
*/
data "nutanix_subnet" "Primary" {
  subnet_name = "Primary"
}