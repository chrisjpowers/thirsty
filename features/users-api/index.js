var express, feat, server, routes, sockjs;
feat = require("feat");
express = require("express");
routes = require("./routes"); 

exports.server = app = express.createServer();

app.get('/recent', routes.recent);
app.get('/users', routes.list);
app.post('/users', routes.checkForDrinks, routes.create);
app.get('/:name', routes.show);
