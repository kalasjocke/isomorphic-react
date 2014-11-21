fs = require 'fs'

React = require 'react'
Router = require 'react-router'
Handlebars = require 'handlebars'
express = require 'express'
morgan = require 'morgan'

Api = require './api'
Store = require './store'
routesFactory = require './components/routes'


layout = Handlebars.compile(fs.readFileSync(__dirname + '/index.handlebars', encoding: 'utf8'))

app = express()
app.use(morgan('dev'))
app.use('/assets', express.static(__dirname + '/../dist'))
app.get('*', (req, res) ->
  store = new Store()
  api = new Api(store, true)
  Router.renderRoutesToString(routesFactory(api, store), req.originalUrl, (err, reason, html) ->
    if not err
      res.send(layout content: new Handlebars.SafeString(html), bootstrap: api.recorded())
    else
      res.status(500).send(err.stack)
  )
)
app.listen 5050
