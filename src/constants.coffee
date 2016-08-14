constants =
  kind:
    single: 0x01
    multi: 0x02

  type:
    music: 0x10
    movie: 0x11
    program: 0x13
    ebook: 0x14
    other: 0x15

  category:
    # Music
    music: 0x20

    # Movies
    movie: 0x22
    tvshow: 0x23
    personnal: 0x24

    # Programs
    game: 0x25
    software: 0x26
    library: 0x27
    app: 0x28

    # eBooks
    cartoon: 0x29
    book: 0x2a
    press: 0x2b

    # Other
    other: 0x2c
    # Seeding purpose only, do nothing
    seeding: 0x2d
  tc:
    music: [0x20]
    movie: [0x22, 0x23, 0x24]
    program: [0x25, 0x26, 0x27, 0x28]
    ebook: [0x29, 0x2a, 0x2b]
    other: [0x2c, 0x2d]
  status:
    # Torrent needs validation
    pending: 0x30
    # Torrent has been validated, need to process
    validated: 0x31
    # Torrent has been processed
    done: 0x32

  source:
    user: 0x40
    auto: 0x41
    both: 0x42


factory = (key) ->
  constants[key].getKey = (val) ->
    for k, v of constants[key]
      if k is 'getKey'
        continue

      if v is val
        return k
    return undefined

for key, obj of constants
  factory key
module.exports = constants
