mongoose = require "../lib/mongo"
Browser = require "zombie"
Browser.site = "http://localhost:8228"

console.log "ENV", process.env.NODE_ENV

before (done) ->
  mongoose.connection.on 'open', ->
    mongoose.connection.db.dropDatabase(done)

beforeEach (done) ->
  mongoose.connection.db.dropDatabase(done)
