# Kubernetes Deployment Lab

## Overview

Helm과 ArgoCD를 활용한 GitOps 기반 배포 환경 구성을 위한 리포지토리 입니다.

## Project Structure

```shell
├── argocd/
│   ├── applications/       # Application manifests
│   ├── appprojects/        # Project configs
│   └── install/            # ArgoCD installation values
│       ├── dev/
│       │   ├── core/
│       │   └── image-updater/
│       ├── stg/
│       └── prod/
├── charts/                 # Helm charts
│   ├── order-service/
│   └── user-service/
├── manifests/              # Raw K8s manifests (practice)
├── script/
│   ├── cluster/kind/       # Local cluster setup
│   ├── gitops/argocd/      # ArgoCD setup
│   └── infrastructure/
└── helmfile.yaml
```

## Prerequisites

- kubectl v1.35.1
- Helm v4.1.1
- Helmfile v1.3.1
- AWS CLI 2.33.28
- Docker v29.2.1