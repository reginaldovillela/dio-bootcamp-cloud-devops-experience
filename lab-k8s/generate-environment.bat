echo "deploy database...";

kubectl apply -f .\database.yaml

echo "finished deploy database...";

echo "deploy backend...";

kubectl apply -f .\backend.yaml

echo "finished deploy backend...";

minikube service lab-k8s-backend-load-balancer --url