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
      torrent.kind = _.findKey(constants.kind)
      torrent.assumedType = _.findKey(constants.type)
      torrent.typeAccuracyPct = Math.round(doc.type.accuracy * 100, 2)

      torrents.push torrent
    console.log torrents
    res.render 'index', torrents: torrents
