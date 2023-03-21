## How to build

### Build the deployer container:
```
make container
```

### Push to docker registry:
```
make deploy
```

## Deploy Portworx on GKE

### Make sure you have the kubeconfig for your GKE cluster
```
kubectl get nodes
```

### Create the Application CRD
```
kubectl apply -f "https://raw.githubusercontent.com/GoogleCloudPlatform/marketplace-k8s-app-tools/master/crd/app-crd.yaml"
```

### Grant your account cluster-admin priveleges
```
kubectl create clusterrolebinding cluster-admin-binding   --clusterrole cluster-admin   --user $(gcloud config get-value account)
```

### Test using mpdev
```
make verify
```

### Deploy using mpdev

```
make install
```

### Quick run build and verify

```
make check
```
NOTE: Instruction to download mpdev can be found [here](https://github.com/GoogleCloudPlatform/marketplace-k8s-app-tools/blob/master/docs/tool-prerequisites.md)
