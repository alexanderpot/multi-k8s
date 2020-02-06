docker build -t alexanderpo/multi-client:latest -t alexanderpo/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t alexanderpo/multi-server:latest -t alexanderpo/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t alexanderpo/multi-worker:latest -t alexanderpo/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push alexanderpo/multi-client:latest
docker push alexanderpo/multi-server:latest
docker push alexanderpo/multi-worker:latest
docker push alexanderpo/multi-client:$SHA
docker push alexanderpo/multi-server:$SHA
docker push alexanderpo/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployment/server-deployment server=alexanderpo/multi-server:$SHA
kubectl set image deployment/client-deployment client=alexanderpo/multi-client:$SHA
kubectl set image deployment/worker-deployment worker=alexanderpo/multi-worker:$SHA
