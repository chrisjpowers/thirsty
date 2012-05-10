User = require "../../lib/user"

module.exports =
  # User pages
  index: (req, res) ->
    User.all (err, users) ->
      res.render "index", title: "Thirsty?", users: users

  details: (req, res) ->
    User.withName req.params.name, (err, user) ->
      res.render "show", title: user.name, user: user
