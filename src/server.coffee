React = require 'react'
express = require 'express'
morgan = require 'morgan'

routes = require './routes'
router = require './router'


PORT = process.env.PORT or 3000

router.configure(routes)
routing = (req, res, next) ->
  router.dispatch req, res, (err) -> next()

app = express()
app.use(routing)
app.use(morgan('dev'))
app.use('/assets', express.static(__dirname + '/../dist'))
app.listen PORT

console.log "Serving at http://localhost:#{PORT}"
