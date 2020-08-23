# Mongo DB

## mongoSingle (Single MongoDB)

### 1. start.sh

### 2. mongo mongodb://localhost:30001
(If you have mongodb in your machine, please execute the above command. If not, you can also do it inside container. In this case, "mongo mongodb://localhost:27017" in your container)

```
yumiyaha@YUMIYAHA-M-7396 mongoSingle % mongo mongodb://localhost:30001  
MongoDB shell version v4.2.5

> 
```

or

```
yumiyaha@YUMIYAHA-M-7396 mongoSingle % ke mongosvr-664c7f7d74-wmddg bash
root@mongosvr-664c7f7d74-wmddg:/# mongo mongodb://localhost:27017
MongoDB shell version v4.2.8

> 
```

### 3. let's execute some commands to be familiar with MongoDB
Create mydb and mycollection
```
> show dbs
admin   0.000GB
config  0.000GB
local   0.000GB

> use mydb
switched to db mydb

> db.createCollection('mycollection')
{ "ok" : 1 }

> show dbs
admin   0.000GB
config  0.000GB
local   0.000GB
mydb    0.000GB
```

Insert data
```
> db.mycollection.insert({name:'john',age:20})
WriteResult({ "nInserted" : 1 })

> db.mycollection.find()
{ "_id" : ObjectId("5ef810b41afbdddbb75a737f"), "name" : "john", "age" : 20 }

```

Update data
```
> db.mycollection.update({name:'john'},{age:90})
WriteResult({ "nMatched" : 1, "nUpserted" : 0, "nModified" : 1 })

> db.mycollection.find()
{ "_id" : ObjectId("5ef810b41afbdddbb75a737f"), "age" : 90 }
```

```
> db.mycollection.update({name:'john'},{$set:{age:90}})
WriteResult({ "nMatched" : 1, "nUpserted" : 0, "nModified" : 1 })

> db.mycollection.find()
{ "_id" : ObjectId("5ef812251afbdddbb75a7380"), "name" : "john", "age" : 90 }
> 
```

```
> db.mycollection.update({name:'john'},{$set:{dept:'it'}})
WriteResult({ "nMatched" : 1, "nUpserted" : 0, "nModified" : 1 })

> db.mycollection.find()
{ "_id" : ObjectId("5ef812251afbdddbb75a7380"), "name" : "john", "age" : 90, "dept" : "it" }
```

Remove data
```
> db.mycollection.update({name:'john'},{$unset:{dept:''}})
WriteResult({ "nMatched" : 1, "nUpserted" : 0, "nModified" : 1 })

> db.mycollection.find()
{ "_id" : ObjectId("5ef812251afbdddbb75a7380"), "name" : "john", "age" : 90 }
```

```
> db.mycollection.remove({name:'john'})
WriteResult({ "nRemoved" : 1 })

> db.mycollection.find()
> 
```

Remove Collection
```
> db.mycollection.drop()
true
> show collections
```

Remove db
```
> db.dropDatabase()
{ "dropped" : "mydb", "ok" : 1 }

> show dbs
admin   0.000GB
config  0.000GB
local   0.000GB
> 
```


## mongoSharding (MongoDB Sharding)

### Config servers
Start config servers (3 member replica set)
Initiate replica set
```
mongo mongodb://localhost:30001
```
```
rs.initiate(
  {
    _id: "cfgrs",
    configsvr: true,
    members: [
      { _id : 0, host : "cfgsvr1" },
      { _id : 1, host : "cfgsvr2" },
      { _id : 2, host : "cfgsvr3" }
    ]
  }
)

rs.status()
```

### Shard 1 servers
Start shard 1 servers (3 member replicas set)
Initiate replica set
```
mongo mongodb://localhost:30005
```
```
rs.initiate(
  {
    _id: "shard1rs",
    members: [
      { _id : 0, host : "shard1svr1" },
      { _id : 1, host : "shard1svr2" },
      { _id : 2, host : "shard1svr3" }
    ]
  }
)

rs.status()
```

### Mongos Router
Start mongos query router

### Add shard to the cluster
Connect to mongos
```
mongo mongodb://localhost:30004
```
Add shard
```
mongos> sh.addShard("shard1rs/shard1svr1,shard1svr2,shard1svr3")
mongos> sh.status()
```
## (Option) Adding another shard

### Duplicate Shard1
Initiate replica set
```
mongo mongodb://localhost:XXXXX
```
```
rs.initiate(
  {
    _id: "shard2rs",
    members: [
      { _id : 0, host : "localhost:XXXXX" },
      { _id : 1, host : "localhost:XXXXX" },
      { _id : 2, host : "localhost:XXXXX" }
    ]
  }
)

rs.status()
```
### Add shard to the cluster
Connect to mongos
```
mongo mongodb://localhost:30004
```
Add shard
```
mongos> sh.addShard("shard2rs/shard2svr1,shard2svr2,shard2svr3")
mongos> sh.status()
```


## Reference
https://github.com/justmeandopensource/learn-mongodb <br>
https://www.youtube.com/watch?v=Q2lJH156SUQ&list=PL34sAs7_26wPvZJqUJhjyNtm7UedWR8Ps&index=6 <br>
https://www.youtube.com/watch?v=Rwg26U0Zs1o&list=PL34sAs7_26wPvZJqUJhjyNtm7UedWR8Ps&index=9 <br>

