FROM node:14


WORKDIR /app

COPY package.json .

RUN npm install

COPY . .

# Only when needed otherwise other layers will need rebuilding
ARG DEFAULT_PORT=80

ENV PORT $DEFAULT_PORT

EXPOSE $PORT

# VOLUME [ "/app/node_modules" ] # or docker run -v /app/node_modules - is an annon volume

CMD [ "npm", "start" ]