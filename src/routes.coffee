#### Routes
# We are setting up theese routes:
#
# GET, POST, PUT, DELETE methods are going to the same controller methods - we dont care.
# We are using method names to determine controller actions for clearness.
torrent = require './controllers/torrent'
index = require './controllers/index'

module.exports = (app) ->

  # simple session authorization
  checkAuth = (req, res, next) ->
    unless req.session.authorized
      res.statusCode = 401
      res.render '401', 401
    else
      next()



  #   - _/_ -> controllers/index/index method
  app.get '/', index.get

  app.get '/confirm', torrent.confirm
  #   - _/**:controller**_  -> controllers/***:controller***/index method
  app.post '/torrent', torrent.add

  app.get '/type/set', torrent.setType

  app.get '/category/set', torrent.setCategory

  app.get '/process', torrent.process
  # If all else failed, show 404 page
  app.all '/*', (req, res) ->
    console.warn "error 404: ", req.url
    res.statusCode = 404
    res.render '404'
