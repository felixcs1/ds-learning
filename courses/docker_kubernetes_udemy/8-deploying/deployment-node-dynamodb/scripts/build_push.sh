aws ecr get-login-password --region eu-west-2 \
 --profile personal | docker login --username AWS --password-stdin 972518559371.dkr.ecr.eu-west-2.amazonaws.com/dynamo-app-repo
docker build -t 972518559371.dkr.ecr.eu-west-2.amazonaws.com/felix-ecr-repo:latest .  
docker push 972518559371.dkr.ecr.eu-west-2.amazonaws.com/felix-ecr-repo:latest