# args.files
# args.name
regexes =
  music: /^(.*\.(flac|mp3|wav|nfo))$/
  movie: /^(.*\.(mp4|mkv|avi|m4a|wmv|srt|nfo))$/
  program: /^(.*\.(exe|dll|cab|sys|zip|ini|cfg|iso|xml|bat|inf|db|bin|dmg|nfo))$/
  ebook: /^(.*\.(pdf|cbr|cbz|epub|mobi|opf|nfo))$/

module.exports = (files) ->
  best_regex_count = 0
  best_regex_name = ''
  for type, regex of regexes
    regex_counter = 0
    for file in files
      if file.match(regex)
        regex_counter += 1
    if regex_counter > best_regex_count
      best_regex_count = regex_counter
      best_regex_name = type
  return {
    type: best_regex_name
    accuracy: best_regex_count / files.length
  }
