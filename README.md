# Kubeflow Metal

## Usage

Run the following in CI or locally before performaing a terraform apply:

```shell
 mkdir kubeflow
 curl https://codeload.github.com/kubeflow-onprem/manifests/tar.gz/refs/tags/v${kubeflow_version} -o kubeflow.tar.gz
 tar xvf kubeflow.tar.gz --directory kubeflow
```

## Istio IngressGateway Service Type

The default kubeflow manifests have a patch that turns the ingress gateway into a NodePort service. To make create a LoadBalancer service to expose Kubeflow externally, delete that patch file and remove it from the kustomization yaml.