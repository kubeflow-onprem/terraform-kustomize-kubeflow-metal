# Kubeflow Metal

## Usage

Run the following in CI or locally before performaing a terraform apply:

```shell
./kubeflow-fetch -v${kubeflow_version}
```

## Istio IngressGateway Service Type

The default kubeflow manifests have a patch that turns the ingress gateway into a NodePort service. To make create a LoadBalancer service to expose Kubeflow externally, delete that patch file and remove it from the kustomization yaml.