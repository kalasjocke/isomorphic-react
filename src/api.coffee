RSVP = require 'rsvp'
Request = require 'superagent'


module.exports = class Api
  base: "https://api.tictail.com/v1"

  constructor: (@store, @record, bootstrap) ->
    @bootstrap = if bootstrap?
      JSON.parse(new Buffer(bootstrap, 'base64').toString('utf8'))
    else
      {}

  recorded: ->
    new Buffer(JSON.stringify(@bootstrap)).toString('base64')

  get: (endpoint, key) ->
    new RSVP.Promise((resolve, reject) =>
      # TODO Make the promise resolve nicer
      if @bootstrap[endpoint]?
        response = @bootstrap[endpoint]
        delete @bootstrap[endpoint]
        @store.set(key, response)
        resolve()
      else
        Request.get("#{@base}/#{endpoint}", (err, res) =>
          if err
            reject(err)
          else
            response = JSON.parse(res.text)
            @store.set(key, response)
            @bootstrap[endpoint] = response if @record
            resolve()
        )
    )
