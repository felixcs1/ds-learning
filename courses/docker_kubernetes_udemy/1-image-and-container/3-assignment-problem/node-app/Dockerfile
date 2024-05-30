FROM node

WORKDIR /app
# . or /app given weve set the working dir
COPY package.json .

RUN npm install

COPY . /app

EXPOSE 3000

CMD ["node", "app.js"]


# from /backend
# docker build -t felixsteph/goals-node . 

# docker run -d --rm --network goals-net
#  -e MONGO_INITDB_ROOT_USERNAME=felix 
#  -e MONGO_INITDB_ROOT_PASSWORD=secret 
#  --name mongodb mongo


# docker run --rm -p 3000:3000
# --network goals-net 
# -v $(pwd):/app -v /app/node_modules
# -e MONGODB_USERNAME=felix 
# -e MONGODB_PASSWORD=secret -e MONGODB_URL=mongodb 
# --name goals-app felixsteph/goals-node