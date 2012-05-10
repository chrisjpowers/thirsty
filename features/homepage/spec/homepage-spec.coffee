require "../../../spec/spec-helper"
expect = require("chai").expect
User = require "../../../lib/user"
Browser = require "zombie"
browser = new Browser

describe "homepage", ->
  beforeEach (done) ->
    g = new User name: "giuseppe", email: "giuseppe@g.com"
    g.save ->
      u = new User name: "chris", email: "chris@chris.com"
      u.addDrink from: "giuseppe", type: "ale", done

  it "responds to GET /", (done) ->
    browser.visit "/", (err) ->
      expect(browser.success).to.equal true
      done()

  it "displays recent user name links", ->
    as = browser.queryAll("#users li a")
    expect(as).to.have.length 2
    expect(as[1].href).to.equal "#{Browser.site}/users/chris"

  it "clicks through to the user's details page", (done) ->
    browser.clickLink "chris", ->
      li = browser.query("li")
      expect(li.innerHTML).to.equal "chris got a ale from giuseppe"
      done()
