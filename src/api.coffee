RSVP = require 'rsvp'
Request = require 'superagent'

{isClient} = require './utils'


module.exports = class Api
  base: "http://gentle-temple-1190.herokuapp.com"

  constructor: ->
    @cache = @_buildCache() if isClient()

  _buildCache: ->
    rv = {}

    for request in window.BOOTSTRAP
      rv[request.endpoint] = request.response

    return rv

  get: (endpoint) ->
    new RSVP.Promise((resolve, reject) =>
      if isClient() and @cache[endpoint]?
        response = @cache[endpoint]

        delete @cache[endpoint]

        resolve(endpoint: endpoint, response: response)
      else
        Request.get("#{@base}/#{endpoint}", (err, res) =>
          response = JSON.parse(res.text)

          if err
            reject(err)
          else
            resolve(endpoint: endpoint, response: response)
        )
    )
