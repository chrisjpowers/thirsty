var express, feat, server, routes;
feat = require("feat");
express = require("express");
routes = require("./routes"); 
require("sockjs");

exports.server = app = express.createServer();

app.configure(function() {
  app.set("views", "" + __dirname + "/views");
  app.set('view engine', 'jade');
  app.use(express.static(__dirname + "/public"));
});

app.get('/', routes.index);
app.get('/recent', routes.recent);
app.get('/users', routes.list);
app.post('/users', routes.checkForDrinks, routes.create);
app.get('/users/:name', routes.details);
app.get('/:name', routes.show);
