

For front end

- set load balancer url in the code App.js
- build image
```
docker build -f frontend/Dockerfile.prod ./frontend -t felixsteph/goals-react
```


Run locally 
```
docker-compose up --build
```