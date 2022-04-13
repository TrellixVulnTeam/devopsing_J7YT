dict=$(kubectl get secret dex-config -n auth -o jsonpath='{.data}')
config=$(cut -d ":" -f2 <<< "$dict")
config="${config:1:-2}"
echo $config | base64 --decode > config.yaml
kubectl create configmap dex -n auth --from-file config.yaml --dry-run -o yaml | kubectl apply -f -
