/**
 * Module dependencies.
 */

var express = require('express')
  , feat = require("feat")
  , app = module.exports = express.createServer()
  , mongoose = require("mongoose");

// Configuration

app.configure(function(){
  app.set('views', __dirname + '/views');
  app.set('view engine', 'jade');
  app.use(express.bodyParser());
  app.use(express.methodOverride());
  app.use(app.router);
  app.use(express.static(__dirname + '/public'));
  app.use(feat.middleware());
});

app.configure('development', function(){
  app.use(express.errorHandler({ dumpExceptions: true, showStack: true }));
  app.use(feat.gui());
});

app.configure('production', function(){
  app.use(express.errorHandler());
});

port = process.env.PORT || 8334
app.listen(port);
console.log("Thirsty is at your service %d in %s mode", port, app.settings.env);
