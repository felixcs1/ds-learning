const path = require('path');

const express = require('express');

const app = express();

app.use(express.static('public'));

app.get('/', (req, res) => {
  const filePath = path.join(__dirname, 'views', 'welcome.html');
  console.log("Request made")
  res.sendFile(filePath);
});

app.get('/healthz', (req, res) => {
  console.log("Health check request")
  
  const healthcheck = {
      uptime: process.uptime(),
      message: 'OK',
      timestamp: Date.now()
  };
  try {
      res.send(healthcheck);
  } catch (error) {
      healthcheck.message = error;
      res.status(503).send();
  }
});

console.log("TESTING LOGS")
app.listen(3000);
