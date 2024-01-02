environment  = "dev"
region       = "UK South"
region_short = "uks"

postgres_vm_size = "B_Standard_B1ms"

jumpbox_vm_size = "Standard_B1s"

k8s_sku_tier          = "Free"
k8s_system_vm_size    = "Standard_B2ps_v2"
k8s_system_node_count = 1
k8s_spot_vm_size      = "Standard_A2_v2" // Consider replacing with Standard_B2pts_v2 if quotas are updated
k8s_spot_node_count   = 2
