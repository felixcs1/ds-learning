# Node Rest API
> A starter project with Node.js, Express and DynamoDB


## Infra

Login to ecr locally
```
aws ecr get-login-password --region eu-west-2 --profile personal | docker login --username AWS --password-stdin 972518559371.dkr.ecr.eu-west-2.amazonaws.com/dynamo-app-repo
```


Build and push 
``` 
docker build -t 972518559371.dkr.ecr.eu-west-2.amazonaws.com/dynamo-app-repo:latest .
docker push 972518559371.dkr.ecr.eu-west-2.amazonaws.com/dynamo-app-repo:latest
```

Run locally 
```
docker run --rm --name dy -p 3000:3000 -v $(pwd):/app -v /app/node_modules -e AWS_SECRET_ACCESS_KEY=<REQUIRED> -e AWS_ACCESS_KEY_ID=<REQUIRED> -e AWS_REGION=eu-west-2 -e DYNAMODB_TABLE_NAME=dynamo-app-dynamodb-table   972518559371.dkr.ecr.eu-west-2.amazonaws.com/dynamo-app-repo:latest
```

Apply infra 
``` 
terraform apply 
```
or 
```
terraform apply -target module.vpc
terraform apply -target module.ecr
terraform apply
```


From blog post: https://faerulsalamun.medium.com/restful-api-with-node-js-express-and-dynamodb-5059beb3ba7f

### Structure

```
.
├── README.md
├── src
│   ├── helpers
│   ├── modules
│   ├── routes
├── app.js
├── server.js
├── .env.example
└── .gitignore

```

## How To Run

1. Copy file .env.example to .env and change with your configuration
2. Run node app.js

## Endpoints

1. GET      /api/v1/users/:UserID       fetch data user by UserID
2. POST     /api/v1/users           create data user
3. PATCH    /api/v1/users/:UserID       update data user by UserID
4. DELETE    /api/v1/users/:UserID      delete data user by UserID
