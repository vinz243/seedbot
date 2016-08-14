mongoose = require 'mongoose'

# User model
Torrent = new mongoose.Schema(
  name: String
  path: String
  kind: Number
  hash: String
  files: [String]
  status: Number
  category: Number
  'type.name': Number
  'type.accuracy': Number
  'type.source': Number
  target: String
)

module.exports = mongoose.model 'Torrent', Torrent
