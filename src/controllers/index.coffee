constants = require '../constants'
Torrent = require '../models/torrent'
_ = require 'lodash'

# Just renders index.jade

exports.index = (req, res) ->

  Torrent.find {}, (err, foundTorrents) ->
    if err
      console.log err
      return res.send err

    torrents = []
    for doc in foundTorrents
      torrent = doc.toObject()
      torrent.kind = constants.kind.getKey(doc.kind)
      torrent.assumedType = constants.type.getKey(doc.type.assumed)
      torrent.typeAccuracyPct = Math.round doc.type.accuracy * 100, 2

      torrent.availableCategories = constants.tc[torrent.assumedType].map (k) ->
        constants.category.getKey(k)

      torrents.push torrent

    console.log torrents
    res.render 'index', torrents: torrents, types: Object.keys(constants.type)
