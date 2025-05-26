provider "azurerm" {
  features {}
  resource_provider_registrations = "none"
  subscription_id = "be857933-7379-4e87-a9fe-02669a1f52c2"
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

