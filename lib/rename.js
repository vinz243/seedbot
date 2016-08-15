var config = require('./config.js');
var fs = require('fs');
var mkdirp = require('mkdirp');
var normalize = require('normalize-path');


module.exports = function(pathFragment) {
  return function(args) {
    // console.log(typeof args.torrent.directory);
    var path = config.targetDir;
    var p = normalize(path) + '/' + normalize(pathFragment) + '/';

    for(let i in args.torrent.files) {
      let file = args.torrent.files[i];
      let relativeFile = file.replace(normalize(args.torrent.directory) + '/',
        '');
      let dirToCreate = p + relativeFile.substring(0, relativeFile.lastIndexOf("/"));
      if (!config.dryRun)
        mkdirp.sync(dirToCreate);
      args.logger.log('mkdir -p ' + dirToCreate);
    }

    switch(config.action) {
      case 'hardlink':
        for(let i in args.torrent.files) {
          let file = args.torrent.files[i];
          var relativeFile = file.replace(normalize(args.torrent.directory) + '/', '');
          if (!config.dryRun)
            try {
              fs.linkSync(file, normalize(p) + '/' + relativeFile);
            } catch (err) {
              args.logger.log(err);
            }
          args.logger.log('Linking ' + file + ' -> ' + p + '/' + relativeFile);
        }
    }
  };
};
