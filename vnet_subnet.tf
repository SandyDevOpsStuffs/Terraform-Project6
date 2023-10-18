# Use the Azure provider configuration from providers.tf in Project5
provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

resource "azurerm_resource_group" "str-grp" {
  name     = "str-grp"  # Use the same resource group name as in Project5
  location = "East US"  # Use the same location as in Project5
}



# Define the Azure Virtual Network (VNet)
resource "azurerm_virtual_network" "example" {
  name                = "SDM-VNet"
  address_space       = ["10.0.0.0/16"]
  location            = "East US"
  resource_group_name = azurerm_resource_group.str-grp.name
}

# Define a subnet within the VNet
resource "azurerm_subnet" "example" {
  name                 = "SDM-Subnet"
  resource_group_name  = azurerm_resource_group.str-grp.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.1.0/24"]
}


terraform {
  backend "azurerm" {
    resource_group_name   = "str-grp"  # Use the resource group name from Project5
    storage_account_name  = "sdmeastusstracc1"  # Use the storage account name from Project5
    container_name        = "str-con-1"  # Choose a container name for Terraform state files
    key                   = "vnet_subnet/project6.tfstate"  # Unique key for this state file
  }
}

