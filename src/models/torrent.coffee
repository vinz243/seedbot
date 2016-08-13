mongoose = require 'mongoose'

# User model
Torrent = new mongoose.Schema(
  name: String
  path: String
  kind: String
  hash: String
  files: [String]
  status: Number
  'cat.assumed': Number
  'cat.validated': Number
  'cat.accuracy': Number
  'cat.source': Number
  'type.assumed': Number
  'type.validated': Number
  'type.accuracy': Number
  'type.source': Number
  target: String
)

module.exports = mongoose.model 'Torrent', Torrent
