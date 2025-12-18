# kubectl Cheatsheet

## k9s 설치

```shell
curl -LO https://github.com/derailed/k9s/releases/download/v0.50.16/k9s_Linux_amd64.tar.gz \
&& tar -xzf k9s_Linux_amd64.tar.gz \
&& sudo install -m 0755 k9s /usr/local/bin/k9s \
&& k9s version
```

## 클러스터/컨텍스트

```shell
kubectl cluster-info
kubectl config get-contexts
kubectl config use-context <ctx>
kubectl config set-context --current --namespace=<ns>
```

## 리소스 조회

```shell
kubectl get pods -A
kubectl get pods -o wide
kubectl get svc
kubectl get deployments
kubectl get all
```

## 리소스 생성/삭제

```shell
kubectl apply -f <file.yaml>
kubectl delete -f <file.yaml>
```

## 롤아웃

```shell
kubectl rollout status deployment/<dep>
kubectl rollout undo deployment/<dep>
kubectl rollout restart deployment/<dep>
```

## 로그/디버깅

```shell
kubectl logs -f <pod>
kubectl exec -it <pod> -- /bin/sh
kubectl port-forward svc/<svc> 8080:80
```
