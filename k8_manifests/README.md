Got it! Let's include the `generate-secret.sh` script in the README.md file to provide a comprehensive guide. Here's the updated README.md:

```markdown
# Kubernetes Manifests for Azure POC

This directory contains Kubernetes manifests for deploying various components of the Azure Proof of Concept (POC) project. These manifests define the desired state of your Kubernetes resources and enable you to manage your infrastructure as code.

## Table of Contents

- [Introduction](#introduction)
- [Prerequisites](#prerequisites)
- [Directory Structure](#directory-structure)
- [Usage](#usage)
  - [Applying Manifests](#applying-manifests)
  - [Using Kustomize](#using-kustomize)
  - [Generating Secrets](#generating-secrets)
- [Manifests](#manifests)
  - [Namespace](#namespace)
  - [Deployment](#deployment)
  - [Service](#service)
  - [ConfigMap](#configmap)
  - [Secret](#secret)
- [Contributing](#contributing)
- [License](#license)

## Introduction

This project demonstrates how to use Kubernetes manifests to deploy and manage applications on a Kubernetes cluster. The manifests include definitions for namespaces, deployments, services, ConfigMaps, and secrets, providing a comprehensive setup for the Azure POC project.

## Prerequisites

Before you begin, ensure you have the following installed:

- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) (v1.18.0 or later)
- Access to a Kubernetes cluster (e.g., [Azure Kubernetes Service (AKS)](https://docs.microsoft.com/en-us/azure/aks/))

## Directory Structure

The directory structure is organized as follows:

```
k8_manifests/
├── configmap.yaml
├── deployment.yaml
├── namespace.yaml
├── secret.yaml
├── service.yaml
├── kustomization.yaml
└── generate-secret.sh
```

## Usage

### Applying Manifests

To apply the Kubernetes manifests individually, use the following command:

```sh
kubectl apply -f <manifest-file>
```

For example, to apply the deployment manifest:

```sh
kubectl apply -f deployment.yaml
```

### Using Kustomize

Kustomize allows you to customize Kubernetes resource configurations. To apply all the manifests using Kustomize, run:

```sh
kubectl apply -k .
```

This command will apply all the resources defined in the `kustomization.yaml` file.

### Generating Secrets

The `generate-secret.sh` script helps you create a Kubernetes secret for your database URL. Follow these steps:

1. **Set the `DATABASE_URL` environment variable**:
   ```sh
   export DATABASE_URL="postgres://user:password@hostname:5432/dbname"
   ```

2. **Run the script to generate the `secret.yaml` file**:
   ```sh
   ./generate-secret.sh
   ```

3. **Apply the generated secret to your Kubernetes cluster**:
   ```sh
   kubectl apply -f secret.yaml
   ```

## Manifests

### Namespace

The `namespace.yaml` file defines a namespace for the Azure POC project:

```yaml
apiVersion: v1
kind: Namespace
metadata:
  name: azure-poc
  labels:
    name: azure-poc
```

### Deployment

The `deployment.yaml` file defines the deployment for the application:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-app
  namespace: azure-poc
spec:
  replicas: 1
  selector:
    matchLabels:
      app: my-app
  template:
    metadata:
      labels:
        app: my-app
    spec:
      containers:
        - name: my-app
          image: myregistry.azurecr.io/my-app:v1.0.0
          envFrom:
            - secretRef:
                name: db-secret
```

### Service

The `service.yaml` file defines the service to expose the application:

```yaml
apiVersion: v1
kind: Service
metadata:
  name: my-app-service
  namespace: azure-poc
spec:
  selector:
    app: my-app
  ports:
    - protocol: TCP
      port: 80
      targetPort: 8080
```

### ConfigMap

The `configmap.yaml` file defines a ConfigMap for the application configuration:

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: app-config
  namespace: azure-poc
data:
  application.properties: |
    key1=value1
    key2=value2
```

### Secret

The `secret.yaml` file defines a secret for sensitive data:

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: db-secret
  namespace: azure-poc
type: Opaque
data:
  DATABASE_URL: <base64-encoded-database-url>
```

## Contributing

We welcome contributions to improve this project. Please follow these steps to contribute:

1. Fork the repository.
2. Create a new branch (`git checkout -b feature-branch`).
3. Make your changes and commit them (`git commit -m 'Add new feature'`).
4. Push to the branch (`git push origin feature-branch`).
5. Create a pull request.

## License

This project is licensed under the MIT License. See the [LICENSE](../LICENSE) file for details.
```

This README.md file now includes instructions for using the `generate-secret.sh` script to create and apply secrets. If you need any further adjustments or have more questions, feel free to ask!

Source: Conversation with Copilot, 2/8/2024
(1) Managing Secrets using Configuration File | Kubernetes. https://kubernetes.io/docs/tasks/configmap-secret/managing-secret-using-config-file/.
(2) Distribute Credentials Securely Using Secrets | Kubernetes. https://kubernetes.io/docs/tasks/inject-data-application/distribute-credentials-secure/.
(3) Secrets | Kubernetes. https://kubernetes.io/docs/concepts/configuration/secret/.
(4) The beginners guide to creating Kubernetes manifests. https://prefetch.net/blog/2019/10/16/the-beginners-guide-to-creating-kubernetes-manifests/.
(5) undefined. https://my.api.com/api/v1.
(6) undefined. https://k8s.io/examples/pods/inject/secret.yaml.
(7) undefined. https://k8s.io/examples/pods/inject/secret-pod.yaml.