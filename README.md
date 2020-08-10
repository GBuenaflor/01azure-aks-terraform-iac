----------------------------------------------------------
#  Azure Kubernetes Services (AKS) - Part 04
 
----------------------------------------------------------
## Provisioning Azure Kubernetes Service with Terraform using Azure DevOps - IaC

High Level Architecture Diagram: 

![Image description](https://github.com/GBuenaflor/01azure-aks-terraform-iac/blob/master/Images/GB-AzureDevOps-AKS-IaC02.png)

Configuration Flow :

1. Install Terraform Plugins reequired for Development Machine and set up Azure DevOps Pipeline
2. Create new Azure DevOps Release Pipeline with service connection to Azure ARM, this will provision AKS Cluster to Azure.
3. Terraform Apply command will provision AKS Cluster to Azure.
4. Terraform Destroy command will de-provision AKS Cluster to Azure.  
5. Check-in Terraform Codes to Github.

----------------------------------------------------------
### 1. Install Terraform Plugins to your Development Machine and set up Azure DevOps Pipeline


#### Install required Terraform Plugins

```  
Terraform 1 
https://marketplace.visualstudio.com/items?itemName=ms-devlabs.custom-terraform-tasks

Terraform 2 
https://marketplace.visualstudio.com/items?itemName=charleszipp.azure-pipelines-tasks-terraform

```

#### Create new Azure DevOps Project
 
```
1.1 Login to https://dev.azure.com/GBBuenaflor and create new Project then create new Pipeline Select Github
```

![Image description](https://github.com/GBuenaflor/01azure-aks-terraform-iac/blob/master/Images/GB-AzureDevOps-AKS-IaC03.png)



```
1.2 
```

![Image description](https://github.com/GBuenaflor/01azure-aks-terraform-iac/blob/master/Images/GB-AzureDevOps-AKS-IaC04.png)



```
1.3 Select your Github Repository
```

![Image description](https://github.com/GBuenaflor/01azure-aks-terraform-iac/blob/master/Images/GB-AzureDevOps-AKS-IaC05.png)



```
1.4 Click starer Pipeline , Then edit the Azure Pipeline code , replace with code in step 3 - 4.
```


```
1.5 Create new Service Connection.
```

![Image description](https://github.com/GBuenaflor/01azure-aks-terraform-iac/blob/master/Images/GB-AzureDevOps-AKS-IaC06.png)

 
 
 
----------------------------------------------------------
### 2. Create new Azure DevOps Release Pipeline with service connection to Azure ARM, this will provision AKS Cluster to Azure.


#### Create new Azure Pipeline trigger, pool, steps and initial task

```
trigger:
- master

pool:
  vmImage: 'ubuntu-latest'

steps:
- script: echo Deploy Azure AKS using Terraform - Azure IaC. 
  displayName: 'Run a multi-line script'

- task: DownloadSecureFile@1
  name: publickey
  inputs:
    secureFile: 'azure_rsa.pub'
```


#### Create task form Terraform command "init" 

```
- task: TerraformCLI@0
  inputs:
    command: 'init'
    workingDirectory: '$(System.DefaultWorkingDirectory)/Web01.kubernetes.Azure.IAC'
    backendType: 'azurerm'
    backendServiceArm: 'AzureARMConnectionDev'
    ensureBackend: true
    backendAzureRmResourceGroupName: 'Dev01-RG'
    backendAzureRmResourceGroupLocation: 'eastus'
    backendAzureRmStorageAccountName: 'dev01straccnt01'
    backendAzureRmContainerName: 'dev01strcontainer01'
    backendAzureRmKey: 'kubernetes-dev01.tfstate'
```

----------------------------------------------------------
### 3. Terraform Apply command will provision AKS Cluster to Azure.


#### Create task form Terraform command "apply" 

```
- task: TerraformCLI@0
  inputs:
    command: 'apply'
    workingDirectory: '$(System.DefaultWorkingDirectory)/Web01.kubernetes.Azure.IAC'
    environmentServiceName: 'AzureARMConnectionDev'
    commandOptions: '-var client_id=$(client_id) -var client_secret=$(client_secret) -var ssh_public_key=$(publickey.secureFilePath) -var tenant_id=$(tenant_id) -var subscription_id=$(subscription_id) -var access_key=$(access_key)'

```

----------------------------------------------------------
### 4. Terraform Destroy command will de-provision AKS Cluster to Azure.  


#### Create task form Terraform command "apply" 

```
- task: TerraformCLI@0
  inputs:
    command: 'destroy'
    workingDirectory: '$(System.DefaultWorkingDirectory)/Web01.kubernetes.Azure.IAC'
    environmentServiceName: 'AzureARMConnectionDev'
    commandOptions: '-var client_id=$(client_id) -var client_secret=$(client_secret) -var ssh_public_key=$(publickey.secureFilePath) -var tenant_id=$(tenant_id) -var subscription_id=$(subscription_id) -var access_key=$(access_key)'

```


----------------------------------------------------------
#### View AKS provisioned (create) using Azure DevOps

![Image description](https://github.com/GBuenaflor/01azure-aks-terraform-iac/blob/master/Images/GB-AzureDevOps-AKS-IaC07.png)



#### View AKS de-provisioned (delete) using Azure DevOps

![Image description](https://github.com/GBuenaflor/01azure-aks-terraform-iac/blob/master/Images/GB-AzureDevOps-AKS-IaC08.png)



</br>
Link to other Microsoft Azure projects
https://github.com/GBuenaflor/01azure
</br>

Note: My Favorite > Microsoft Technologies
