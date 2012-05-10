User = require "../../lib/user"

module.exports =
  # API
  list: (req, res) ->
    User.all (err, users) ->
      res.send users

  recent: (req, res) ->
    User.recentDrinkers (err, users) ->
      res.send users

  show: (req, res) ->
    User.withName req.params.name, (err, user) ->
      res.send user

 create: (req, res) ->
    if req.body.drink
      User.withName req.body.drink.to, (err, user) ->
        if err then return res.send(err)
        drink = {type: req.body.drink.type, from: req.body.drink.from, to: req.body.drink.to, email: req.body.drink.email}
        if user
          user.addDrink drink, (err) ->
            if err then throw err
            res.send user
        else
          User.createFromDrink req.body.drink, (err, user) ->
            if err then return res.send(err)
            res.send user
    else
      res.send error: "looks like you're missing some stuff"

  checkForDrinks: (req, res, next) ->
    User.withName req.body.drink.from, (er, pal) ->
      if er then throw er
      return next new Error("That's not a user") unless pal

      if pal.hasDrinksToGive()
        next()
      else
        next(new Error('User Has no drinks to give.'))

