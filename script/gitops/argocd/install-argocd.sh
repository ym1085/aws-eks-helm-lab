#!/bin/bash
set -e
echo "======================================"
echo "Installing ArgoCD Service on kind k8s cluster"
echo "======================================"

echo "개발 환경을 선택 해주세요"
echo "1: dev, 2:stg, 3:prod"
read -p "번호를 입력하세요: " ENV_NUM
case "${ENV_NUM}" in
    1) PROFILE="dev";;
    2) PROFILE="stg";;
    3) PROFILE="prod";;
    *) 
      echo "잘못된 입력입니다. 1, 2, 3 중 하나를 선택해주세요." 
      exit 1;;
esac

# 기존 namespace 삭제 (있을 경우)
echo "0. 기존 ArgoCD namespace 삭제 중..."
kubectl delete namespace argocd --ignore-not-found=true
echo " 삭제 완료 대기"
kubectl wait --for=delete namespace/argocd --timeout=60s >/dev/null || true

# 경로 계산
SCRIPT_DIR="$(cd "$(dirname "$BASH_SOURCE[0]")" && pwd)"
ARGOCD_DIR="$SCRIPT_DIR/../../.."
echo -e "ARGOCD_DIR: $ARGOCD_DIR\n"
sleep 5

# ArgoCD namespace 생성
echo "1. ArgoCD namespace 생성 중..."
kubectl create \
    namespace argocd \
    --dry-run=client -o yaml | kubectl apply -f -

# Helm 리포지토리 추가
echo "2. Helm 리포지토리 추가 중..."
helm repo add argo https://argoproj.github.io/argo-helm
helm repo update

# ArgoCD 설치 (Helm + values.yaml)
# https://artifacthub.io/packages/helm/argo/argo-cd
ARGOCD_VERSION=9.3.4
echo "3. ArgoCD 설치 중 (Helm)"
helm install argocd argo/argo-cd \
    --namespace argocd \
    --version $ARGOCD_VERSION \
    -f "$ARGOCD_DIR/argocd/install/${PROFILE}/core/values.yaml" \
    --wait

# Image Updater 설치
helm install argocd-image-updater argo/argocd-image-updater \
    --namespace argocd \
    --version 0.12.0 \
    -f "$ARGOCD_DIR/argocd/install/${PROFILE}/image-updater/values.yaml"

# AppProject 생성
echo "4. AppProject 생성 중..."
kubectl apply -f "$ARGOCD_DIR/argocd/appprojects/${PROFILE}/project.yaml"

# Applications 생성
echo "5. Applications 생성 중..."
kubectl apply -f "$ARGOCD_DIR/argocd/applications/${PROFILE}/"

# ArgoCD 서버 Pod가 준비될때까지 대기
echo "6. ArgoCD 서버 Pod가 준비될때까지 대기..."
kubectl wait \
    --for=condition=ready pod \
    -l app.kubernetes.io/name=argocd-server \
    -n argocd \
    --timeout=300s

# ArgoCD admin password 조회
echo "6. ArgoCD admin password 확인 중..."
ARGOCD_PASSWORD=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)

echo
echo "======================================"
echo "ArgoCD 설치가 완료되었습니다."
echo "======================================"
echo ""
echo "ArgoCD URL: https://argocd-server.argocd.svc.cluster.local"
echo "ArgoCD Username: admin"
echo "ArgoCD Password: $ARGOCD_PASSWORD"
echo "======================================"
echo "포트 포워딩으로 UI 접속:"
echo " kubectl port-forward svc/argocd-server 8080:443 -n argocd"
echo " https://localhost:8080"
echo "======================================"
echo "NodePort로 UI 접속:"
echo " kubectl patch svc argocd-server -p '{\"spec\":{\"type\":\"NodePort\"}}' -n argocd"
echo " https://<node-ip>:<node-port>"
echo "======================================"