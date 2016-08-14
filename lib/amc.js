

let child_process = require('child_process');
let config = require('./config');

let _ = require('lodash');


module.exports = function(args, flags) {
  flags = _.assign(flags, {
    fetchArtworks: false,
    isMusic: true
  });
  def = {
    unsorted: 'n',
    music: flags.isMusic ? 'y': 'n',
    artwork: config.fetchArtworks ? 'y' : 'n',
    ut_title: args.torrent.name,
    ut_dir: args.torrent.directory,
    ut_kind: args.constants.kind.getKey(args.torrent.kind),
    ut_file: args.torrent.kind === args.constants.kind.single ?
      args.torrent.name : ''
  };
  defArgs = '"' + _.join(_.zip(_.keys(def), _.values(def)).map(function(key) {
    return _.join(key, '=');
  }), '" "') + '"';

  filebotArgs = {
    '-script': 'fn:amc',
    '--output': config.mediaCenterDir,
    '--action': config.action,
    '--conflict': 'skip',
    '-non-strict': '',
    '--log-file': config.amcLogFile,
    '--def': defArgs
  };

  cmd = _.join([].concat.apply([],
    _.zip(_.keys(filebotArgs), _.values(filebotArgs))
  ), ' ');

  args.logger.log('Executing filebot with arguments:\n' + cmd);

  if (!config.dryRun) {
      var output;
      try {
        output = child_process.execSync('filebot ' + cmd);
      } catch(err) {
        output = err;
      }
      args.logger.log(output);
  }
};

/*
filebot -script fn:amc --output "X:/Media" --action copy --conflict skip -non-strict --log-file amc.log
 --def unsorted=y music=y artwork=y "ut_label=%L" "ut_state=%S" "ut_title=%N" "ut_kind=%K" "ut_file=%F" "ut_dir=%D"**
 */
