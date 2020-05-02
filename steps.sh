#Create a headless service
kubectl apply -f service-headless.yaml

#Create a storage class
kubectl apply -f storage-class.yaml
kubectl get sc

#Create stateful service
kubectl apply -f statefulset.yaml
kubectl get statefulset

#Check the pods
kubectl get po

#Check persisten volumes
kubectl get pvc,pv

#Connect replica 0
kubectl exec -it mongo-0 mongo

#Initiate the replicaset
rs.initiate({_id: "rs0", version: 1, members: [
  { _id: 0, host : "mongo-0.mongodb-svc.default.svc.cluster.local:27017" },
  { _id: 1, host : "mongo-1.mongodb-svc.default.svc.cluster.local:27017" },
  { _id: 2, host : "mongo-2.mongodb-svc.default.svc.cluster.local:27017" }
]});

rs.conf()
rs.status()

#Test the MongoDB
kubectl apply -f mongo-express.yaml

#Check mongo-1
kubectl exec -it mongo-1 mongo
rs.slaveOk()
show dbs
use returngis
db.people.find()