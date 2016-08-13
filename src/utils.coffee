exports.walkSync = (dir, filelist) ->
  fs = fs or require('fs')
  files = fs.readdirSync(dir)
  filelist = filelist or []
  files.forEach (file) ->
    if fs.statSync(dir + '/' + file).isDirectory()
      filelist = walkSync(dir + '/' + file + '/', filelist)
    else
      filelist.push dir + '/' + file
    return
  filelist
