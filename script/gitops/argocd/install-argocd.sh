#!/bin/bash
set -e

echo "======================================"
echo "Installing ArgoCD Service on kind k8s cluster"
echo "======================================"

# ArgoCD namespace 생성
echo "1. ArgoCD namespace 생성 중..."
kubectl create \
    namespace argocd \
    --dry-run=client -o yaml | kubectl apply -f -

# ArgoCD 설치
echo "2. ArgoCD 설치 중..."
kubectl apply \
    -n argocd \
    -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# ArgoCD 서버 Pod가 준비될때까지 대기
echo "3. ArgoCD 서버 Pod가 준비될때까지 대기 중..."
kubectl wait \
    --for=condition=ready pod \
    -l app.kubernetes.io/name=argocd-server \
    -n argocd \
    --timeout=300s

# ArgoCD admin password 조회
echo "4. ArgoCD admin password 확인 중..."
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