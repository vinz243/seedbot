/**
args = {
  torrent: {
    name: Torrent name
    directory: Torrent dir
    files: [torrent files]
    kind: constants.kind.single or constants.kind.multi
  }
  constants: see constants file
}
*/
module.exports = require('./rename.js')('games')
