FROM node

RUN apt-get update && apt-get install -y \
curl

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install && \
    rm -rf aws awscliv2.zip

WORKDIR /app

COPY package.json .

RUN npm install

COPY . .

EXPOSE 3000

# ENV AWS_ACCESS_KEY_ID=some-access-key
# ENV AWS_SECRET_ACCESS_KEY=some-secret-key
ENV AWS_REGION=some_region
ENV DYNAMODB_TABLE_NAME=some_name

CMD ["node", "app.js"]