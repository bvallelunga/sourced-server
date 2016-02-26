module.exports = (app, routes)->
  app.get '/logout', routes.auth.logout
