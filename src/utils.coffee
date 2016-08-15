normalize = require 'normalize-path'

walkSync = (dir, filelist) ->
  fs = fs or require('fs')
  files = fs.readdirSync(dir)
  filelist = filelist or []
  files.forEach (file) ->
    if fs.statSync(dir + '/' + file).isDirectory()
      filelist = walkSync(normalize(dir) + '/' + normalize(file) + '/', filelist)
    else
      filelist.push normalize(dir) + '/' + normalize(file)
    return
  filelist

exports.walkSync = walkSync
