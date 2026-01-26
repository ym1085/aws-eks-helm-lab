# AWS EKS Helm Lab

> A hands-on laboratory repository for practicing Kubernetes deployments on AWS EKS using Helm charts and Helmfile.

## Overview

Deploy microservices to AWS EKS using Helm and Helmfile with multi-environment support.

## Project Structure

```shell
.
├── argocd/                              # ArgoCD GitOps
│   ├── applications/                    # Application
│   │   ├── dev/
│   │   ├── prod/
│   │   └── stg/
│   ├── appprojects/                     # AppProject
│   │   ├── dev/
│   │   ├── prod/
│   │   └── stg/
│   └── install/                         # ArgoCD installation
│       ├── dev/
│       ├── prod/
│       └── stg/
├── charts/                              # Helm charts
│   ├── order-service/
│   │   └── templates/
│   └── user-service/
│       └── templates/
├── manifests/                           # Raw Kubernetes
│   └── lab/                             # Practice
│       ├── deployment/
│       ├── namespace/
│       ├── pod/
│       ├── quotas/
│       └── service/
├── script/                              # Utility scripts
│   ├── cluster/
│   │   └── kind/                        # KIND cluster
│   ├── gitops/
│   │   └── argocd/                      # ArgoCD installation
│   └── infrastructure/
│       └── ingress-controller/
└── helmfile.yaml                        # Helmfile
```

## Prerequisites

- kubectl v1.34.1
- Helm v3.x
- Helmfile v1.1.7
- Kustomize v5.7.1
- AWS CLI 2.13.8
- Docker v29.x.x

## Environments

> The project supports multiple environments

- `dev`: Development environment
- `stg`: Staging environment
- `prod`: Production environment

## Deployment

### 1. Create Kind Cluster

```bash
./script/cluster/kind/start-cluster.sh
```

### 2. Deploy with Helmfile

```bash
# Deploy all services
helmfile -e dev apply

# Deploy specific service
helmfile -e dev -l name=order-service apply
helmfile -e dev -l name=user-service apply
helmfile -e dev -l name=ingress-controller apply

# Verify deployment
kubectl get pods -A
```

### 3. Deploy with ArgoCD

```bash
# Install ArgoCD (select env: 1=dev, 2=stg, 3=prod)
./script/gitops/argocd/install-argocd.sh

# Access UI
kubectl port-forward svc/argocd-server 8080:443 -n argocd
# https://localhost:8080

# Get password
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
```
