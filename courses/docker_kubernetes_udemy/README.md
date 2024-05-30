# Notes


### Volumes

prune images

`docker image prune -a --force --filter "until=168h"`

Named volume
-v feedback:/app/feedback - 
- name:path in container
- Survives container shut down
- So, can be used to share data between containers 

Annoymous volume
-v /app/node_modules
- Path in contain
- Does not survive container shutdown
- used to avoid overwriting data from local through other volumnes
- the more specific paths get priority e.g /app/nodemdules over just /app in another bind mount/named volume

Bind Mount
-v $(pwd):/app
- Survives container shut down
- Can be shared across containers
- Needs absolute path
- used to have your local code cahnges reflected in contianer w/i rebuidling image
- add :ro to make it read only (container catn write to the local disk)


Connections 

- Container to www - just works as normal
- Container to host maching - urls replace 'localhost' with 'host.docker.internal'
- Container to container 
    - Naive `docker inspect container-name` to get IP adress of container, then put that in the url.
    - better 
        - `docker network create <NAME>`. Inspect with docker network ls.
        - `docker run .... --network <NAME>` for all container that need to communicate
        - In urls just have the container name instead of e.g `'mongodb://mongodb-container-name:27017/swfavorites',`

- Note only need to publish/expose ports if you want to connect to container from local host/ outside container in general



Long docker run commands
DB
```
docker run -d --rm -e MONGO_INITDB_ROOT_USERNAME=felix -e MONGO_INITDB_ROOT_PASSWORD=secret --name mongodb --network goals-net -v mongodb-persistance:/data/db  mongo              
```

Backend service
```
docker run --rm -d  --name backend-container --network goals-net -p 2000:80 -e MONGO_USER=felix -e MONGO_PASSWORD=secret -v $(pwd):/app -v /app/node_modules  -v $(pwd)/logs:/app/logs  backend
```

Frontend react app
```
docker run -d  --rm -p 3000:3000 --name frontend-container -v $(pwd)/src:/app/src -it --network goals-net frontend
```


## Compose 
Automatically runs with --rm. And -d can be used with the compose command.
`docker-compose down` - to delete volumes use -d 
`docker-compose up` 

`--build` forces an image rebuild

`docker-compose build` - just build images, dont run containers


## utility containers

`docker run -it -v $(pwd):/app  node-util npm init` - custom command after container, bind mount to reflect it on local

`CMD` - if you add a command after image name in docker run, the CMD woudl be overwritten
`ENTRYPOINT` - command after image name in docker run are APPENDED to whatever is in the 

with docker compse 
`docker-compose run --rm  npm-util init` - --rm does not happen by default


use depends_on, and then `docker-compose up -d single_container` will run it and all dependant services

`docker-compose up` does not auto rebuild images, need to add `--build`


In `docker-compose.yaml` - the build context sets the folder the image will be **built from**


# Deploying 

Some tutorials:
- https://www.architect.io/blog/2021-03-30/create-and-manage-an-aws-ecs-cluster-with-terraform/
- https://medium.com/@bhasvanth/create-aws-efs-and-mount-in-ecs-fargate-container-using-terraform-8ce1d68b7eef


Naive
- build and push image locally to hub 
- launch Ec2, allow ingress on ports 22 and 80 (or whatever port your app listens on)
- Ssh into ec2, install docker and pull image and run, then go to public ip to test


Managed (ECS)
- 


Get terminal in container
```
aws ecs execute-command \
  --region eu-west-2 \
  --cluster goals-cluster \
  --task 37b37092bdd84ae9bae11daad44b0003 \
  --container goals-container \
  --command "/bin/bash" \
  --interactive --profile personal
```

Post request within container
```
curl "localhost:3001/goals"
{"message":"Healthy"}root curl -H 'Content-Type: application/json' \: application/json' \
      -d '{ "text": "some goal"}' \
      -X POST \
```

Mounting EFS
- Can check this be sshing into container and running `df -T`:

```
root@ip-10-0-2-54:/# df -T
Filesystem                                         Type           1K-blocks     Used        Available Use% Mounted on
overlay                                            overlay         30787492 12450364         16747880  43% /
/dev/nvme1n1                                       ext4            30787492 12450364         16747880  43% /data/configdb
fs-0743d6cb8f466b441.efs.eu-west-2.amazonaws.com:/ nfs4    9007199254739968        0 9007199254739968   0% /data/db <----- HERE! 
tmpfs                                              tmpfs             475040        0           475040   0% /sys/firmware
```


## ECR:

```
aws ecr get-login-password --region eu-west-2 --profile personal | docker login --username AWS --password-stdin 972518559371.dkr.ecr.eu-west-2.amazonaws.com/dynamo-app-repo
```

```
docker build -t 972518559371.dkr.ecr.eu-west-2.amazonaws.com/dynamo-app-repo:latest . 

OR build then tag:

docker tag 40a12d9a6c41 972518559371.dkr.ecr.eu-west-2.amazonaws.com/dynamo-app-repo:latest
```

```
docker push 972518559371.dkr.ecr.eu-west-2.amazonaws.com/dynamo-app-repo:latest
```