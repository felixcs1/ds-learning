FROM node

WORKDIR /app

# . or /app given weve set the working dir
COPY package.json . 

RUN npm install

COPY . .

EXPOSE 80

CMD ["node", "server.js"]