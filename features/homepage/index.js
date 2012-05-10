var express, feat, server, routes, sockjs;
feat = require("feat");
express = require("express");
routes = require("./routes"); 

exports.server = app = express.createServer();

app.configure(function() {
  app.set("views", "" + __dirname + "/views");
  app.set('view engine', 'jade');
  app.use(express.static(__dirname + "/public"));
});

app.get('/', routes.index);
app.get('/users/:name', routes.details);
