constants = require '../constants'
Torrent = require '../models/torrent'
_ = require 'lodash'

# Just renders index.jade

exports.get = (req, res) ->

  Torrent.find {
    status:
      $ne: constants.status.done
  }, (err, foundTorrents) ->
    if err
      console.log err
      return res.send err

    torrents = []
    for doc in foundTorrents
      torrent = doc.toObject()
      torrent.kind = constants.kind.getKey(doc.kind)
      torrent.type = constants.type.getKey(doc.type.name)
      torrent.isAutotype = doc.type.source is constants.source.auto
      torrent.typeAccuracyPct = Math.round doc.type.accuracy * 100, 2
      torrent.isValidated = doc.status is constants.status.validated
      #console.log torrent
      if not torrent.type
        torrent.type = 'other'
      torrent.availableCategories = constants.tc[torrent.type].map (k) ->
        constants.category.getKey(k)

      torrent.categoryName = constants.category.getKey(doc.category)

      torrents.push torrent
    res.render 'index', torrents: torrents, types: Object.keys(constants.type)
