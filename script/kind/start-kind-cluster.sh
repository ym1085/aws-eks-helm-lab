#!/bin/bash
set -e

echo "==================================="
echo " Kubernetes in Docker (kind) Setup "
echo "==================================="
echo

kind create cluster --config kind-config-nodeport.yaml
kubectl cluster-info --context kind-kind
kubectl get nodes