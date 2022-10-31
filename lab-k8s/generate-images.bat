echo "generating image backend...";

docker build ./backend -t reginaldovillela/lab-k8s-backend:1.0

docker push reginaldovillela/lab-k8s-backend:1.0

echo "finished generating image backend...";

echo "generating image database...";

docker build ./database -t reginaldovillela/lab-k8s-database:1.0

docker push reginaldovillela/lab-k8s-database:1.0

echo "finished generating image database...";