var mongoose = require('mongoose');
mongoose.connect('mongodb://localhost/beer');

var Schema = mongoose.Schema;

var Drinks = new Schema({
  type:  { type: String, required: true}
, drunk: { type: Date, default: null }
, from:  { type: String, requred: true }
});

var User = new Schema({  
  name:       { type: String, required: true, unique: true}
, drinks:     [Drinks]
, email:      { type: String, requred: true }
, lastDrink:  { type: Date, default: Date.now }
, updatedAt:  { type: Date, default: Date.now }
});

module.exports = mongoose.model('User', User);
