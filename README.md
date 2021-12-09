# Kubeflow Metal

## Usage

Run the following in CI or locally before performaing a terraform apply:

```shell
 mkdir kubeflow
 curl https://codeload.github.com/kubeflow-onprem/manifests/tar.gz/refs/tags/v${kubeflow_version} -o kubeflow.tar.gz
 tar xvf kubeflow.tar.gz --directory kubeflow
```