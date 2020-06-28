kubectl apply -f config-server/cfgsvr1-service.yaml &&\
kubectl apply -f config-server/cfgsvr2-service.yaml &&\
kubectl apply -f config-server/cfgsvr3-service.yaml &&\
kubectl apply -f mongos/mongos-service.yaml &&\
kubectl apply -f shard1/shard1svr1-service.yaml &&\
kubectl apply -f shard1/shard1svr2-service.yaml &&\
kubectl apply -f shard1/shard1svr3-service.yaml &&\
sleep 5s && kubectl get po