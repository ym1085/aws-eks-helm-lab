# Helm Cheatsheet

## Helm 설치

```shell
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
helm version
```

## Helm 기본 명령어

```shell
helm repo add <name> <url>
helm repo update
helm search repo <keyword>

helm install <release> <chart>
helm upgrade <release> <chart>
helm uninstall <release>

helm list
helm status <release>
helm history <release>
helm rollback <release> <revision>
```

## Helmfile 설치

```shell
export HELMFILE_VER=1.2.2
export GOARCH="$(uname -m | sed 's/x86_64/amd64/; s/aarch64/arm64/')"

curl -fL -o /tmp/helmfile.tar.gz "https://github.com/helmfile/helmfile/releases/download/v${HELMFILE_VER}/helmfile_${HELMFILE_VER}_linux_${GOARCH}.tar.gz"
tar -xzf /tmp/helmfile.tar.gz -C /tmp
sudo install -m 755 /tmp/helmfile /usr/local/bin/helmfile

helmfile --version
```

## Helmfile 기본 명령어

```shell
helmfile -e <env> apply
helmfile -e <env> sync
helmfile -e <env> diff
helmfile -e <env> template
helmfile -e <env> list
helmfile -e <env> destroy
```
