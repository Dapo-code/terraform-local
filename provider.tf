# The cloud function connects your local config to your terraform cloud workspace
terraform { 
  cloud { 
    
    organization = "Dapo_code" 

    workspaces { 
      name = "workspace-dev" 
    } 
  } 
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.116.0"
    }
  }
}

provider "azurerm" {
    subscription_id = "5d519402-d62b-4a0d-93cd-bd98fe938726"
    tenant_id = "536c4d46-b757-419d-abbd-a28c79ef3064"
    client_id = "c7694489-75ee-4db5-ac89-d38cc1b6deb2"
    client_secret = "dyX8Q~J5qzj-.fdd2UfF8j-uTPQiHic5IgAu6bnY"
    features {}
}