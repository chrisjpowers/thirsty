mongoose = require('./mongo')

secondAgo = ->
  d = new Date()
  d.setDate(d.getDate() - 1)
  d

Schema = mongoose.Schema

DrinksSchema = new Schema
  type:  { type: String, required: true}
  drunk: { type: Date, default: null }
  from:  { type: String, requred: true }

UserSchema = new Schema
  name:       { type: String, required: true, unique: true}
  drinks:     [DrinksSchema]
  email:      { type: String, required: true }
  lastDrink:  { type: Date, default: secondAgo }
  updatedAt:  { type: Date, default: Date.now }

User = module.exports = mongoose.model('User', UserSchema)

User.all = (cb) ->
  @find {}, cb

User.withName = (name, cb) ->
  @findOne name: name, cb

User.recentDrinkers = (cb) ->
  @find($where: "this.drinks.length > 0", cb).sort("updatedAt", -1)

User.createFromDrink = (drink, cb) ->
  user = new User name: drink.to, email: drink.email
  user.addDrink drink, cb

User::addDrink = (drink, cb) ->
  recipient = this
  User.withName drink.from, (err, giver) ->
    giver.lastDrink = new Date()
    giver.save()
    recipient.drinks.push drink
    recipient.updateTimestamps()
    recipient.save cb

User::updateTimestamps = ->
  @updatedAt = new Date()

User::hasDrinksToGive = ->
  today = new Date()
  lastbeer = new Date(pal.lastDrink)
  !(lastbeer.getMonth() == today.getMonth() && lastbeer.getDate() == today.getDate())


