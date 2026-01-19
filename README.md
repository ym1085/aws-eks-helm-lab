# AWS EKS Helm Lab

> A hands-on laboratory repository for practicing Kubernetes deployments on AWS EKS using Helm charts and Helmfile.

## Overview

Deploy microservices to AWS EKS using Helm and Helmfile with multi-environment support.

## Project Structure

```shell
.
├── argocd/                              # ArgoCD GitOps configurations
│   ├── applications/                    # Application definitions
│   │   └── dev/
│   ├── appprojects/                     # AppProject definitions
│   │   └── dev/
│   └── install/                         # ArgoCD installation settings
│       └── dev/
├── charts/                              # Helm charts for microservices
│   ├── order-service/
│   │   └── templates/
│   └── user-service/
│       └── templates/
├── manifests/                           # Raw Kubernetes manifests
│   └── lab/                             # Practice manifests
│       ├── deployment/
│       ├── namespace/
│       ├── pod/
│       ├── quotas/
│       └── service/
├── script/                              # Utility scripts
│   ├── cluster/
│   │   └── kind/                        # KIND cluster configurations
│   ├── gitops/
│   │   └── argocd/                      # ArgoCD installation script
│   └── infrastructure/
│       └── ingress-controller/
│           └── alb/                     # AWS ALB Controller
└── helmfile.yaml                        # Helmfile configuration
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

### Using Helmfile

> Deploy services using Helmfile

```bash
# Deploy to dev environment
helmfile -e dev -l name=order-service apply
helmfile -e dev -l name=user-service apply

# Deploy to stg environment
helmfile -e stg -l name=order-service apply
helmfile -e stg -l name=user-service apply

# Deploy to prod environment
helmfile -e prod -l name=order-service apply
helmfile -e prod -l name=user-service apply
```

### Using ArgoCD

> Deploy services using ArgoCD

```bash
# Install argocd
./script/gitops/argocd/install-argocd.sh

# Access ArgoCD UI
# URL: http://localhost:30180
# Username: admin
# Password: kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
```