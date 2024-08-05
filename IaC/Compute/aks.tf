resource "azurerm_kubernetes_cluster" "poc_aks_cluster" {
  name                    = "poc-aks-cluster"
  location                = var.location
  resource_group_name     = var.azurerm_resource_group
  dns_prefix              = "poc-akscluster"
  private_cluster_enabled = true # Enable private cluster
  default_node_pool {
    name           = "default"
    node_count     = 1
    vm_size        = "Standard_B2s" # Cost-effective VM size
    vnet_subnet_id = var.subnet_id
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin    = "azure"
    load_balancer_sku = "standard" # Basic load balancer to reduce costs
  }
  /*
  role_based_access_control {
    enabled = true
  }

  addon_profile {
    oms_agent {
      enabled = false
    }
  }
*/

  tags = {
    environment = "development"
  }

  depends_on = [
    var.azurerm_container_registry
  ]
}

resource "azurerm_role_assignment" "acr_pull" {
  principal_id         = azurerm_kubernetes_cluster.poc_aks_cluster.kubelet_identity[0].object_id
  role_definition_name = "AcrPull"
  scope                = var.azurerm_container_registry_id
}

resource "azurerm_role_assignment" "network_contributor" {
  principal_id   = azurerm_kubernetes_cluster.poc_aks_cluster.identity[0].principal_id
  role_definition_name = "Network Contributor"
  scope          = var.virtual_network_id
}

output "kube_config" {
  value     = azurerm_kubernetes_cluster.poc_aks_cluster.kube_config_raw
  sensitive = true
}