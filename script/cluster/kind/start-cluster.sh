#!/bin/bash
set -e
echo "==================================="
echo " Kubernetes in Docker (kind) Setup "
echo "==================================="
echo
KIND_CONFIG=$(ls *.yaml | head -n 1)
if [[ -z $KIND_CONFIG ]]; then
  echo '파일이 존재하지 않습니다.'
  exit 1
fi
echo 'Filename => $KIND_CONFIG'
kind create cluster --config $KIND_CONFIG
kubectl ctx
kubectl get nodes
#kubectl cluster-info --context kind-helm-cluster
#kubectl get nodes
