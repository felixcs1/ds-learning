FROM node

WORKDIR /app

RUN apt-get update && apt-get install -y \
curl

COPY package.json .

RUN npm install

COPY . .

EXPOSE 3000

ENV MONGODB_USERNAME=root
ENV MONGODB_PASSWORD=secret
ENV MONGODB_URL=mongodb

CMD ["node", "app.js"]