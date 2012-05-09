/**
 * Module dependencies.
 */

var express = require('express')
  , feat = require("feat")
  , app = module.exports = express.createServer();

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

app.listen(8334);
console.log("Thirsty is at your service %d in %s mode", app.address().port, app.settings.env);
