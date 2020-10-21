docker build -t slneo/multi-client:latest -t slneo/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t slneo/multi-server:latest -t slneo/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t slneo/multi-worker:latest -t slneo/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push slneo/multi-client:latest
docker push slneo/multi-server:latest
docker push slneo/multi-worker:latest

docker push slneo/multi-client:$SHA
docker push slneo/multi-server:$SHA
docker push slneo/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=slneo/multi-server:$SHA
kubectl set image deployments/client-deployment client=slneo/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=slneo/multi-worker:$SHA

