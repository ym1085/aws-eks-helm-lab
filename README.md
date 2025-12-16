# AWS EKS Helm Lab

> A hands-on laboratory repository for practicing Kubernetes deployments on AWS EKS using Helm charts and Helmfile.

## Overview

Deploy microservices to AWS EKS using Helm and Helmfile with multi-environment support.

## Project Structure

```
.
├── charts/                    # Helm charts for microservices
│   ├── order-service/         # Order service Helm chart
│   └── user-service/          # User service Helm chart
├── deploy/                    # Deployment configurations
│   └── helmfile.yaml          # Helmfile for managing releases
├── manifests/                 # Raw Kubernetes manifests
│   ├── namespace/             # Namespace definitions
│   ├── playground/            # Practice manifests (pods, deployments, services)
│   └── quotas/                # Resource quota configurations
└── script/                    # Utility scripts
    └── kind/                  # KIND cluster configurations
    └── aws-lb-controller/     # AWS ALB Loadbalancer Controller
```

## Prerequisites

- kubectl v1.34.1
- Helm v3.x
- Helmfile v1.1.7
- Kustomize v5.7.1
- AWS CLI 2.13.8

## Environments

> The project supports multiple environments

- `dev`: Development environment
- `stg`: Staging environment
- `prod`: Production environment

## Deployment

> Deploy services using Helmfile

```bash
# Deploy to development environment
cd deploy
helmfile -e dev apply

# Deploy to staging environment
helmfile -e stg apply

# Deploy to production environment
helmfile -e prod apply
```