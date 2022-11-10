terraform {
  required_version = ">= 0.13"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "> 2.0"
    }
  }
}

provider "azurerm" {
  skip_provider_registration = true
  features {}
}
#select Subscription
data "azurerm_subscription" "current" {}

#1:- Policy Allowed Specific Locaton

resource "azurerm_policy_definition" "AllowedSpecificLocation" {
  name         = "AllowedSpecificLocation"
  policy_type  = "Custom"
  mode         = "Indexed"
  display_name = "AllowedSpecificLocation"
lifecycle {
    ignore_changes = [ metadata]
    }

    metadata = file ("${path.module}/LocationMetadata.json" )
    policy_rule = file ("${path.module}/LocationPolicyRule.json" )
    parameters = file ("${path.module}/LocationParameters.json")
}


 resource "azurerm_subscription_policy_assignment" "AllowedSpecificLocation" {
  name                 = "AllowedSpecificLocation"
  subscription_id      = data.azurerm_subscription.current.id
  policy_definition_id = azurerm_policy_definition.AllowedSpecificLocation.id
  description          = "Allowed Specific Location"
  display_name         = "AllowedSpecificLocation"
  location             = "eastus2"
  identity { type = "SystemAssigned" }
  parameters = <<PARAMETERS
{
    "listOfAllowedLocations": {
    "value": [
          "east us2",
          "east us",
          "west us2"
        ]
      }
}
PARAMETERS
 }

#2:- Policy Allowed Tag Values for VM

resource "azurerm_policy_definition" "allowedtagValuesForVM" {
  name         = "allowedtagValuesForVM"
  policy_type  = "Custom"
  mode         = "Indexed"
  display_name = "allowedtagValuesForVM"
lifecycle {
    ignore_changes = [ metadata]
    }

    metadata = file ("${path.module}/allowedtagValuesForVMPolicyMetadata.json" )
    policy_rule = file ("${path.module}/allowedtagValuesForVMPolicyRule.json" )
    parameters = file ("${path.module}/allowedtagValuesForVMPolicyParameters.json")
}


 resource "azurerm_subscription_policy_assignment" "allowedtagValuesForVM" {
  name                 = "allowedtagValuesForVM"
  subscription_id      = data.azurerm_subscription.current.id
  policy_definition_id = azurerm_policy_definition.allowedtagValuesForVM.id
  description          = "Allowed Tag Values for VM"
  display_name         = "allowedtagValuesForVM"
  location             = "eastus2"
  identity { type = "SystemAssigned" }
parameters = <<PARAMETERS
{
    "tagName": {
    "value": "environment"
      },
  "listofallowedtagValues": {
         "value": [
          "dev",
          "test",
          "prod"
        ],
        "defaultValue": [
          "prod"
        ]
      }
}
PARAMETERS
}

#3 :- Policy Key Valut Disable Public Network Access

resource "azurerm_policy_definition" "KeyValutDisablePublicNetworkAccess" {
  name         = "KeyValutDisablePublicNetworkAccess"
  policy_type  = "Custom"
  mode         = "Indexed"
  display_name = "KeyValutDisablePublicNetworkAccess"
lifecycle {
    ignore_changes = [ metadata]
    }

    metadata = file ("${path.module}/KeyValutDisablePublicNetworkAccessPolicyMetadata.json" )
    policy_rule = file ("${path.module}/KeyValutDisablePublicNetworkAccessPolicyRule.json" )
    parameters = file ("${path.module}/KeyValutDisablePublicNetworkAccessPolicyParameters.json")
}


 resource "azurerm_subscription_policy_assignment" "KeyValutDisablePublicNetworkAccess" {
  name                 = "KeyValutDisablePublicNetworkAccess"
  subscription_id      = data.azurerm_subscription.current.id
  policy_definition_id = azurerm_policy_definition.KeyValutDisablePublicNetworkAccess.id
  description          = "KeyValut Should Disable Public Network Access"
  display_name         = "KeyValutDisablePublicNetworkAccess"
  location             = "eastus2"
  identity { type = "SystemAssigned" }
 }
#4 :- Policy Storage Account Public Access Disallowed 
resource "azurerm_policy_definition" "Storageaccountpublicaccessdisallowed" {
  name         = "Storageaccountpublicaccessdisallowed"
  policy_type  = "Custom"
  mode         = "Indexed"
  display_name = "Storage Account Public Access Disallowed"
lifecycle {
    ignore_changes = [ metadata]
    }

    metadata = file ("${path.module}/StorageaccountpublicaccessdisallowedPolicyMetadata.json" )
    policy_rule = file ("${path.module}/StorageaccountpublicaccessdisallowedPolicyRule.json" )
    parameters = file ("${path.module}/StorageaccountpublicaccessdisallowedPolicyParameters.json")
}


 resource "azurerm_subscription_policy_assignment" "Storageaccountpublicaccessdisallowed" {
  name                 = "Storageaccountpublicaccessdisallowed"
  subscription_id      = data.azurerm_subscription.current.id
  policy_definition_id = azurerm_policy_definition.Storageaccountpublicaccessdisallowed.id
  description          = "KeyValutDisablePublicNetworkAccess"
  display_name         = "Storage Account Public Access Disallowed"
  location             = "eastus2"
  identity { type = "SystemAssigned" }
 }

#5 :- Policy  Network Interface Access Should not have public IPs

 resource "azurerm_policy_definition" "NetworkinterfacesshouldnothavepublicIPs" {
  name         = "NetworkinterfacesshouldnothavepublicIPs"
  policy_type  = "Custom"
  mode         = "Indexed"
  display_name = "Network Interfaces Shouldnot Have Public IPs"
lifecycle {
    ignore_changes = [ metadata]
    }

    metadata = file ("${path.module}/NetworkinterfacesshouldnothavepublicIPsPolicyMetadata.json" )
    policy_rule = file ("${path.module}/NetworkinterfacesshouldnothavepublicIPsPolicyRule.json" )
    parameters = file ("${path.module}/NetworkinterfacesshouldnothavepublicIPsPolicyParameters.json")
}


 resource "azurerm_subscription_policy_assignment" "NetworkinterfacesshouldnothavepublicIPs" {
  name                 = "NetworkinterfacesshouldnothavepublicIPs"
  subscription_id      = data.azurerm_subscription.current.id
  policy_definition_id = azurerm_policy_definition.NetworkinterfacesshouldnothavepublicIPs.id
  description          = "KeyValutDisablePublicNetworkAccess"
  display_name         = "Network Interfaces Shouldnot Have Public IPs"
  location             = "eastus2"
  identity { type = "SystemAssigned" }
 }

#6 :- Policy   Flow Log Enable for NSG To Central Storage Account

resource "azurerm_policy_definition" "FlowlogEnableforNSGToCentralStorageAccount" {
  name         = "FlowlogEnableforNSGToCentralStorageAccount"
  policy_type  = "Custom"
  mode         = "Indexed"
  display_name = "Enable Flow log for NSG To Central Storage Account"
lifecycle {
    ignore_changes = [ metadata]
    }

    metadata = file ("${path.module}/FlowlogEnableforNSGToCentralStorageAccountPolicyMetadata.json" )
    policy_rule = file ("${path.module}/FlowlogEnableforNSGToCentralStorageAccountPolicyRule.json" )
    parameters = file ("${path.module}/FlowlogEnableforNSGToCentralStorageAccountPolicyParameters.json")
}


 resource "azurerm_subscription_policy_assignment" "FlowlogEnableforNSGToCentralStorageAccount" {
  name                 = "FlowlogEnableforNSGToCentralStorageAccount"
  subscription_id      = data.azurerm_subscription.current.id
  policy_definition_id = azurerm_policy_definition.FlowlogEnableforNSGToCentralStorageAccount.id
  description          = "Enable Flow log for NSG To Central Storage Account"
  display_name         = "Enable Flow log for NSG To Central Storage Account"
  location             = "eastus2"
  identity { type = "SystemAssigned" }
parameters = <<PARAMETERS
{
    "nsgRegion": {
    "value": "eastus"
      },
  "storageId": {
         "value": "/subscriptions/343c17eb-34b6-4481-92a2-a0a5a04bdd88/resourceGroups/NetworkWatcherRG/providers/Microsoft.Storage/storageAccounts/ntwatchstrgacct" 
      },
 "networkWatcherRG": {
    "value": "NetworkWatcherRG"
      },
	  "networkWatcherName": {
    "value": "NetworkWatcher_eastus"
      }
	  }
PARAMETERS
}

#7 :- Policy Storage Account Encryption CMK Encryption Data At Rest

resource "azurerm_policy_definition" "StorageAccountEncryptionCMKEncryptDataAtRest" {
  name         = "StorageAccountEncryptionCMKEncryptDataAtRest"
  policy_type  = "Custom"
  mode         = "Indexed"
  display_name = "Enable Storage Account Encryption Data At Rest"
lifecycle {
    ignore_changes = [ metadata]
    }
 
    metadata = file ("${path.module}/StorageAccountEncryptionCMKEncryptDataAtRestPolicyMetadata.json" )
    policy_rule = file ("${path.module}/StorageAccountEncryptionCMKEncryptDataAtRestPolicyRule.json" )
    parameters = file ("${path.module}/StorageAccountEncryptionCMKEncryptDataAtRestPolicyParameters.json")
}


 resource "azurerm_subscription_policy_assignment" "StorageAccountEncryptionCMKEncryptDataAtRest" {
  name                 = "StorageAccountEncryptionCMKEncryptDataAtRest"
  subscription_id      = data.azurerm_subscription.current.id
  policy_definition_id = azurerm_policy_definition.StorageAccountEncryptionCMKEncryptDataAtRest.id
  description          = "Enable Storage Account Encryption Data At Rest"
  display_name         = "Enable Storage Account Encryption Data At Rest"
  location             = "eastus2"
  identity { type = "SystemAssigned" }
 }

#8 :- Policy Subnets Should Associated with NSG
 resource "azurerm_policy_definition" "SubnetsShouldAssociatedwithNSG" {
  name         = "SubnetsShouldAssociatedwithNSG"
  policy_type  = "Custom"
  mode         = "Indexed"
  display_name = "Subnets Should Associated with NSG"
lifecycle {
    ignore_changes = [ metadata]
    }

    metadata = file ("${path.module}/SubnetsShouldAssociatedwithNSGPolicyMetadata.json" )
    policy_rule = file ("${path.module}/SubnetsShouldAssociatedwithNSGPolicyRule.json" )
    parameters = file ("${path.module}/SubnetsShouldAssociatedwithNSGPolicyParameters.json")
}


 resource "azurerm_subscription_policy_assignment" "SubnetsShouldAssociatedwithNSG" {
  name                 = "SubnetsShouldAssociatedwithNSG"
  subscription_id      = data.azurerm_subscription.current.id
  policy_definition_id = azurerm_policy_definition.SubnetsShouldAssociatedwithNSG.id
  description          = "Subnets Should Associated with NSG"
  display_name         = "Subnets Should Associated with NSG"
  location             = "eastus2"
  identity { type = "SystemAssigned" }
 }

resource "azurerm_policy_definition" "VMAndVMscalesetshostencryptionenabled" {
  name         = "VMAndVMscalesetshostencryptionenabled"
  policy_type  = "Custom"
  mode         = "Indexed"
  display_name = "VM And VM scale sets host encryption enabled"
lifecycle {
    ignore_changes = [ metadata]
    }
    metadata = file ("${path.module}/VMAndVMscalesetshostencryptionenabledPolicyMetadata.json" )
    policy_rule = file ("${path.module}/VMAndVMscalesetshostencryptionenabledPolicyRule.json" )
    parameters = file ("${path.module}/VMAndVMscalesetshostencryptionenabledPolicyParameters.json")
}

#9 :- Policy Subnets VM And VM scalesets host encryption enabled
 resource "azurerm_subscription_policy_assignment" "VMAndVMscalesetshostencryptionenabled" {
  name                 = "VMAndVMscalesetshostencryptionenabled"
  subscription_id      = data.azurerm_subscription.current.id
  policy_definition_id = azurerm_policy_definition.VMAndVMscalesetshostencryptionenabled.id
  description          = "VM And VM scale sets host encryption enabled"
  display_name         = "VM And VM scale sets host encryption enabled"
  location             = "eastus2"
  identity { type = "SystemAssigned" }
 }


resource "azurerm_policy_definition" "NamingStandard_VirtualMachine" {
  name         = "NamingStandard_VirtualMachine"
  policy_type  = "Custom"
  mode         = "Indexed"
  display_name = "Naming Standard Virtual Machine"
lifecycle {
    ignore_changes = [ metadata]
    }
 
    metadata = file ("${path.module}/NamingStandard_VirtualMachinePolicyMetadata.json" )
    policy_rule = file ("${path.module}/NamingStandard_VirtualMachinePolicyRule.json" )
    parameters = file ("${path.module}/NamingStandard_VirtualMachinePolicyParameters.json")
}

#10 :- Policy Naming Standard Virtual Machine
 resource "azurerm_subscription_policy_assignment" "NamingStandard_VirtualMachine" {
  name                 = "NamingStandard_VirtualMachine"
  subscription_id      = data.azurerm_subscription.current.id
  policy_definition_id = azurerm_policy_definition.NamingStandard_VirtualMachine.id
  description          = "Naming Standard Virtual Machine"
  display_name         = "Naming Standard Virtual Machine"
  location             = "eastus2"
  identity { type = "SystemAssigned" }
  
 parameters = <<PARAMETERS
{
    "Application": {
    "value": "finapp"
      },
  "Environment": {
         "value": "d"
      },
 "DataCenterCountry": {
    "value":   "ae"
      },
      "DataCenterLocation": {
        "value":  "e"
      },
	  "WebTier": {
	  "value": "w"
      },
	"LogicTier": {
	  "value":      "l"
      },
	   "DataTier": {
	  "value": "d"
      }
	    }
PARAMETERS
}
