docker build -t yapcheekian/multi-client:latest -t yapcheekian/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t yapcheekian/multi-server:latest -t yapcheekian/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t yapcheekian/multi-worker:latest -t yapcheekian/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push yapcheekian/multi-client:latest
docker push yapcheekian/multi-server:latest
docker push yapcheekian/multi-worker:latest

docker push yapcheekian/multi-client:$SHA
docker push yapcheekian/multi-server:$SHA
docker push yapcheekian/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=yapcheekian/multi-server:$SHA
kubectl set image deployments/client-deployment web=yapcheekian/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=yapcheekian/multi-worker:$SHA