# [LAB_RULES] AWS EKS Helm & GitOps

## 1. Development Standards

- **Manifests:** YAML (2-space), K8s naming, `app.kubernetes.io/*` labels mandatory.
- **Helm:** SemVer, Environment-agnostic `values.yaml`, Environment-specific `values-{env}.yaml`.
- **Scripts:** Bash (set -euo pipefail), Usage/Prerequisite validation required.

## 2. GitOps & Environment Strategy

- **dev:** Auto-sync & Self-heal.
- **stg/prod:** Manual sync & Approval required.
- **ArgoCD:** `{service}-{env}` naming, AppProject isolation.
- **Tools:** kubectl v1.34.1, Helm v3, Helmfile v1.1.7, Kustomize v5.7.1.

## 3. Directory Structure

- `/charts`: Reusable Helm charts.
- `/argocd/applications`: Env-specific ArgoCD manifests.
- `/script`: Infrastructure & GitOps automation.
- `/manifests/lab`: Learning-purpose raw manifests.

## 4. Operational Protocol

1. **Change Suggestion:** Specify environment -> Provide Helm/ArgoCD methods -> Verification command.
2. **Resource Creation:** Create chart -> Setup ArgoCD apps for ALL envs -> Update helmfile.yaml.
3. **Troubleshooting:** Context/Namespace check -> Helm status -> ArgoCD sync status -> Logs/Events.
