React = require 'react'
director = require 'director'

{isServer} = require './utils'


class Router
  configure: (routes) ->
    if isServer()
      @router = new director.http.Router(@_makeServerRoutes(routes))
    else
      @router = director.Router(@_makeClientRoutes(routes)).configure(html5history: true)
      @router.init()

  setRoute: (route) ->
    @router.setRoute(route)

  dispatch: (req, res, callback) ->
    @router.dispatch(req, res, callback)

  _makeServerRoutes: (routes) ->
    Handlebars = require 'handlebars'
    fs = require 'fs'

    layout = Handlebars.compile(fs.readFileSync(__dirname + '/index.handlebars', encoding: 'utf8'))

    rv = {}

    for route, handler of routes
      do (handler) ->
        rv[route] =
          get: (args...) ->
            handler(args).then(([component, bootstrap]) =>
              try
                @res.status(200).send(layout(
                  content: React.renderComponentToString(component),
                  bootstrap: JSON.stringify(bootstrap),
                ))
              catch error
                stack = error.stack
                console.log error.stack

                @res.status(500).send("<code>#{stack}</code>")
            )
    return rv

  _makeClientRoutes: (routes) ->
    rv = {}

    for route, handler of routes
      do (handler) ->
        rv[route] = (args...) ->
          handler(args).then(([component, _]) =>
            React.renderComponent component, document.getElementById('app')
          ).catch((err) -> console.log err)

    return rv


module.exports = new Router()
