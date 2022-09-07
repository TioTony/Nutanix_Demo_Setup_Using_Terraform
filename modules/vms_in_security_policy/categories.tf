/*
TH: Define the categories that will be used for a simple security policy
*/

# Existing AppType
data "nutanix_category_key" "AppTypeKey"{
    name = "AppType"
}

# Add AppType value for Secure_Desktop
resource "nutanix_category_value" "TH_TF_Secure_AppType_Desktop"{
    name = data.nutanix_category_key.AppTypeKey.id
    value = "TH_TF_Secure_AppType_Desktop"
}

# Existing AppTier
data "nutanix_category_key" "AppTierKey"{
    name = "AppTier"
}

# Add AppTier value for Secure Desktop
resource "nutanix_category_value" "TH_TF_Secure_AppTier_Desktop"{
    name = data.nutanix_category_key.AppTierKey.id
    value = "TH_TF_Secure_AppTier_Desktop"
}