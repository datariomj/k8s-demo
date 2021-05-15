docker build -t datariomj/multi-client:latest -t datariomj/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t datariomj/multi-server:latest -t datariomj/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t datariomj/multi-worker:latest -t datariomj/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push datariomj/multi-client:latest
docker push datariomj/multi-server:latest
docker push datariomj/multi-worker:latest

docker push datariomj/multi-client:$SHA
docker push datariomj/multi-server:$SHA
docker push datariomj/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment server=datariomj/multi-client:$SHA
kubectl set image deployments/server-deployment server=datariomj/multi-server:$SHA
kubectl set image deployments/worker-deployment server=datariomj/multi-worker:$SHA