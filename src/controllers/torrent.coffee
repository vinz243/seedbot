Torrent = require '../models/torrent'

autotype = require '../autotype'
constants = require '../constants'
jetpack  = require 'fs-jetpack'
normalize = require 'normalize-path'
utils = require '../utils'


module.exports =
  confirm: (req, res) ->
    if not req.query.id
      return res.send 400
    Torrent.findByIdAndUpdate req.query.id, {
      $set:
        status: constants.status.validated
    }, (err, doc) ->
      if err
        console.log err
        return res.send 500

      res.redirect '/'
  setType: (req, res) ->
    if not req.query.id
      return res.send 400
    if not req.query.type or not constants.type[req.query.type]
      return res.send 400

    Torrent.findByIdAndUpdate(req.query.id,
      {
        $set: {
          'type.name': constants.type[req.query.type]
          'type.source': constants.source.user
        }
      }
    , (err, torrent) ->
      if err
        console.log err
      res.redirect '/'
    )

  setCategory: (req, res) ->
    if not req.query.id or not req.query.cat
      res.send 400
    if not constants.category[req.query.cat]
      res.send 400
    Torrent.findByIdAndUpdate(req.query.id, {
      $set: {
        category: constants.category[req.query.cat]
      }
    }, (err, doc) ->
      if err
        console.log err
      res.redirect '/'
    )


  add: (req, res) ->
    console.log(req.body)

    result = jetpack.exists(normalize(req.body.path) + '/' + req.body.name)

    if not result
      res.statusCode = 400
      return res.send('400 File not found')

    res.send 200

    cwd = jetpack.cwd(req.body.path)
    if result is 'file'
      files = [
        normalize(req.body.path) + '/' + req.body.name
      ]
      kind = 'single'
    else
      files = utils.walkSync(cwd.path(req.body.name))

    console.log('Trying autotype...')

    report = autotype(files)

    torrent = new Torrent {
      name: req.body.name
      path: req.body.path
      hash: req.hash
      files: files
      kind: constants.kind[kind]
      'type.name': constants.type[report.type]
      status: constants.status.pending
      'type.accuracy': report.accuracy
      'type.source': constants.source.auto
    }
    torrent.save((err) ->
      console.log(err)
    )
