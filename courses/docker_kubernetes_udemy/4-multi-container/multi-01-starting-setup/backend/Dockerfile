FROM node

WORKDIR /app

COPY package.json ./

RUN npm install

COPY . .

EXPOSE 80 

ARG LANG
ENV MONGO_USER=$LANG
ENV MONGO_PASSWORD=secret

RUN echo ${MONGO_USER}

CMD ["npm", "start"]

