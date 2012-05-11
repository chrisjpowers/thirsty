require "../../../spec/spec-helper"
request = require "request"
expect = require("chai").expect
Browser = require "zombie"
User = require "../../../lib/user"

describe "Users API", ->
  user1 = user2 = null
  beforeEach (done) ->
    user1 = new User name: "User1", email: "user1@example.com"
    user2 = new User name: "User2", email: "user2@example.com"
    user1.save (err) ->
      user2.addDrink type: "beer", from: "User1", ->
        done()

  get = (relativeUrl, cb) ->
    request Browser.site + relativeUrl, (err, res, body) ->
      cb JSON.parse(body)

  post = (relativeUrl, data, cb) ->
    console.log data.drink
    request.post url: Browser.site + relativeUrl, json: data, (err, res, body) ->
      try
        res = JSON.parse body
      catch e
        e.message = "Unable to JSON.parse '#{body}'"
        throw e
      cb(res)

  describe "GET /users", ->
    it "returns all users", (done) ->
      get "/users", (data) ->
        expect(data).to.have.length 2
        expect(data[0].name).to.equal "User1"
        expect(data[1].name).to.equal "User2"
        expect(data[0].email).to.equal "user1@example.com"
        expect(data[1].email).to.equal "user2@example.com"
        done()

  describe "GET /recent", ->
    it "returns users that have had a drink", (done) ->
      get "/users", (data) ->
        get "/recent", (data) ->
          expect(data).to.have.length 1
          expect(data[0].name).to.equal "User2"
          expect(data[0].email).to.equal "user2@example.com"
          done()

  describe "GET /:name", ->
    it "returns the user with the given name", (done) ->
      get "/User1", (user) ->
        expect(user.email).to.equal "user1@example.com"
        get "/User2", (user) ->
          expect(user.email).to.equal "user2@example.com"
          done()

  describe "POST /users", ->
    describe "giving drink to new user", ->
      it "creates the recipient and adds the drink", (done) ->
        drink = type: "beer", from: "User2", to: "NewUser", email: "new@example.com"
        post "/users", drink: drink, (data) ->
          get "/User3", (user) ->
            expect(user.name).to.equal "User3"
            expect(user.email).to.equal "new@example.com"
            expect(user.drinks).to.have.length 1
            done()
