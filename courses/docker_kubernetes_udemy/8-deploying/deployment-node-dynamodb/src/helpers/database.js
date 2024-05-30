var AWS = require('aws-sdk');

AWS.config.getCredentials(function(err) {
    if (err) {
        console.log("CREDS NOT LOADED", err.stack);
        process.exit()
    } else {
      console.log("Access key:", AWS.config.credentials.accessKeyId);
    }
  });

console.log("HELLO WORLD", process.env.AWS_SECRET_ACCESS_KEY)

const db = new AWS.DynamoDB.DocumentClient({convertEmptyValues: true});

module.exports = db;
