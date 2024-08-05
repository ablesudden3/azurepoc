<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.113.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_compute"></a> [compute](#module\_compute) | ./Compute | n/a |
| <a name="module_network"></a> [network](#module\_network) | ./Network | n/a |
| <a name="module_storage"></a> [storage](#module\_storage) | ./storage | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group.sandip-poc](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_address_space"></a> [address\_space](#input\_address\_space) | n/a | `list(any)` | n/a | yes |
| <a name="input_azurerm_resource_group"></a> [azurerm\_resource\_group](#input\_azurerm\_resource\_group) | n/a | `string` | n/a | yes |
| <a name="input_client_id"></a> [client\_id](#input\_client\_id) | n/a | `string` | n/a | yes |
| <a name="input_client_secret"></a> [client\_secret](#input\_client\_secret) | n/a | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Location for the azure cloud resources | `string` | n/a | yes |
| <a name="input_storage_account_name"></a> [storage\_account\_name](#input\_storage\_account\_name) | n/a | `string` | n/a | yes |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | n/a | `string` | n/a | yes |
| <a name="input_tenant_id"></a> [tenant\_id](#input\_tenant\_id) | n/a | `string` | n/a | yes |
| <a name="input_vnet_name"></a> [vnet\_name](#input\_vnet\_name) | n/a | `string` | n/a | yes |

# Azure POC Infrastructure as Code (IaC)

This repository contains the Terraform code for provisioning and managing Azure resources as part of a Proof of Concept (POC) for Microsoft Azure.

## Table of Contents

- Introduction
- Prerequisites
- Getting Started
  - Clone the Repository
  - Configure Environment Variables
  - Initialize Terraform
  - Apply the Configuration
- Modules
- Outputs
- Contributing
- License

## Introduction

This project demonstrates how to use Terraform to automate the deployment of Azure resources. It includes modules for creating virtual networks, storage accounts, and other essential infrastructure components.

## Prerequisites

Before you begin, ensure you have the following installed:

- Terraform (v1.0.0 or later)
- Azure CLI (v2.0.0 or later)
- An Azure subscription

## Getting Started

### Clone the Repository

Clone this repository to your local machine:

```sh
git clone https://github.com/ablesudden3/azurepoc.git
cd azurepoc/IaC


Configure Environment Variables
Set up your Azure credentials. You can do this by running:

az login

Initialize Terraform
Initialize the Terraform configuration:
terraform init
