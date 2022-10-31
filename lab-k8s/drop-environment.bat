echo "drop database...";

kubectl delete service lab-k8s-database-conn
kubectl delete pod lab-k8s-database

echo "finished drop database...";

echo "drop backend...";

kubectl delete service lab-k8s-backend-load-balancer
kubectl delete deploy lab-k8s-backend-deployment

echo "finished drop backend...";

@REM echo "drop storage...";

@REM kubectl delete pvc db-local
@REM kubectl delete pv db-local

@REM echo "finished drop storage...";