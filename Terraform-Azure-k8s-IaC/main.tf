#######################################################
# Azure Terraform - Infrastructure as a Code (IaC)
# 
# Use this two Azure DepOps Pipeline:
# azure-pipelines-1.yml - Deploy Azure AKS using Terraform - Azure IaC
# azure-pipelines-2.yml - Destroy Azure AKS using Terraform - Azure IaC
# 
# ----------------------------------------------------
#  Initial Configuration
# ----------------------------------------------------
# - Run this in Azure CLI
#   az login
#   az ad sp create-for-rbac -n "AzureTerraform" --role="Contributor" --scopes="/subscriptions/[SubscriptionID]"
#
# - Then complete the variables in the variables.tf file
#   - subscription_id  
#   - client_id  
#   - client_secret  
#   - tenant_id  
#   - ssh_public_key  
#   - access_key
#
####################################################### 
#----------------------------------------------------
# Azure Terraform Provider
#----------------------------------------------------

provider "azurerm" { 
  features {}
  version = ">=2.0.0"  
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id 
}

#----------------------------------------------------
# Resource Group
#----------------------------------------------------

resource "azurerm_resource_group" "resource_group" {
  name     = var.resource_group
  location = var.location
}
 
#----------------------------------------------------
# Azure AKS Cluster
#----------------------------------------------------

resource "azurerm_kubernetes_cluster" "terraform-k8s" {
  name                = "${var.cluster_name}_${var.environment}"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  dns_prefix          = var.dns_prefix

  linux_profile {
    admin_username = "ubuntu"

    ssh_key {
      key_data = file(var.ssh_public_key)
    }
  }

  default_node_pool {
    name            = "agentpool"
    node_count      = var.node_count
    vm_size         = var.vm_size
  }

  service_principal {
    client_id     = var.client_id
    client_secret = var.client_secret
  }

  tags = {
    Environment = var.environment
  }
}


#----------------------------------------------------
# Terraform BackEnd
#----------------------------------------------------

terraform {
  backend "azurerm" {
      storage_account_name= "dev01straccnt01"  
      access_key= "1qxGagOl73iVmc/KBZJvKS1aHHG/MIDS6BHRd3OXi5PFav6fNBPv3h0xhEr1zvHsaLkMzHw/UcOxMf09yNnSsQ==" 
      key= "dev01.k8s.tfstate"              
      container_name= "dev01strcontainer01" 
	}
}
