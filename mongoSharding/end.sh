kubectl delete -f config-server/cfgsvr1-service.yaml &&\
kubectl delete -f config-server/cfgsvr2-service.yaml &&\
kubectl delete -f config-server/cfgsvr3-service.yaml &&\
kubectl delete -f mongos/mongos-service.yaml &&\
kubectl delete -f shard1/shard1svr1-service.yaml &&\
kubectl delete -f shard1/shard1svr2-service.yaml &&\
kubectl delete -f shard1/shard1svr3-service.yaml &&\
sleep 5s && kubectl get all