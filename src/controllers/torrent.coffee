Torrent = require '../models/torrent'

autotype = require '../autotype'
constants = require '../constants'
jetpack  = require 'fs-jetpack'
normalize = require 'normalize-path'
utils = require '../utils'


module.exports =
  post: (req, res) ->
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
      'type.assumed': constants.type[report.type]
      status: constants.status.pending
      'type.accuracy': report.accuracy
      'type.source': constants.source.auto
    }
    torrent.save((err) ->
      console.log(err)
    )
