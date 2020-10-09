Dockerfile-MemcachedRepcached
=============================

Dockerfile For Memcached Repcached

Usage:
```
主节点1: (11311是服务监听端口,11411是数据同步端口;-x 指定replicaIP,-X指定replica监听端口) 
docker run -d -p 0.0.0.0:11311:11311 -p 0.0.0.0:11411:11411 --name memcachedrepcached1 wjw465150/memcachedrepcached -m 200 -v -u root -l 0.0.0.0 -p 11311 -X 11411 -x ${主节点2}
```
```
主节点2: (11311是服务监听端口,11411是数据同步端口;-x 指定replicaIP,-X指定replica监听端口)
docker run -d -p 0.0.0.0:11311:11311 -p 0.0.0.0:11411:11411 --name memcachedrepcached2 wjw465150/memcachedrepcached -m 200 -v -u root -l 0.0.0.0 -p 11311 -X 11411 -x ${主节点1}
```

Memcached Cachedump

Usage:
```
stats cachedump {slab_id} [start_num] {limit_num}
```
