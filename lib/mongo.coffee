fs = require "fs"
mongoose = require "mongoose"

env = process.env.NODE_ENV || "development"
config = JSON.parse fs.readFileSync("#{__dirname}/../config/mongo.json")
config = config[env]
mongoose.connect config.host, config.database

module.exports = mongoose
