# Create cluster
- Run
```bash
kind create cluster --config admin-k8s/cluster-config.yml
```
# Kubernetes dashboard
- Create kubernetes-dashboard objects by running
```bash
helm repo add kubernetes-dashboard https://kubernetes.github.io/dashboard/
helm install kubernetes-dashboard kubernetes-dashboard/kubernetes-dashboard -n kubernetes-dashboard --create-namespace
```
- Run the following
```bash
kubectl proxy
```
- Access the dashboard [here](http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:https/proxy/)
- Create a service account to access dashboard
```bash
kubectl apply -f admin-k8s/admin-service-account.yml
```
- Get the access token by running
```bash
kubectl describe serviceaccount admin-user -n kubernetes-dashboard
# Get Tokens value for the next command
kubectl describe secret <Tokens> -n kubernetes-dashboard
# Get token value to login
```

# Commands
- Create secret for postgress password
```bash
kubectl create secret generic pgpassword --from-literal PGPASSWORD=<Password>
```
- Create objets for app
```bash
kubectl apply -f k8s/
```
# Travis CI
- docker run -it -v $(pwd):/app ruby:2.4 sh