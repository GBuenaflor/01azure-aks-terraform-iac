#----------------------------------------------------
#  Replace correct values or configure values in Azure DevOps variables :
#
#  - subscription_id  
#  - client_id  
#  - client_secret  
#  - tenant_id  
#  - ssh_public_key  
#  - access_key
#---------------------------------------------------- 

variable subscription_id {
   default = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx" 
}

variable client_id       {
    default = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
 }

variable client_secret   {
    default = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
 }

variable tenant_id       {
    default = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
 }

variable ssh_public_key {
   default = "azure_rsa.pub"
}

#----------------------------------------------------
# Azure Storage Account
#---------------------------------------------------- 
    
variable storage_account_name {
    default = "dev01straccnt01"
}
 
variable access_key {
    default = "1qxGagOl73iVmc/KBZJvKS1aHHG/MIDS6BHRd3OXi5PFav6fNBPv3h0xhEr1zvHsaLkMzHw/UcOxMf09yNnSsQ==" 
}
  
variable key {
    default = "dev01.k8s.tfstate"
}
  
variable container_name {
    default = "dev01strcontainer01"
}
  
#----------------------------------------------------
# Azure AKS Variables
#----------------------------------------------------
    
variable environment {
    default = "Dev"
}

variable location {
    default = "eastus"
}

variable node_count {
  default = 2
}

variable dns_prefix {
  default = "aks01"
}

variable cluster_name {
  default = "aks01"
}

variable vm_size {
  default = "Standard_D2_v3" # "Standard_DS1_v2"
}

variable resource_group {
  default = "Dev01-aks01-RG"
}
