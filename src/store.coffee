module.exports = class Store
  constructor: ->
    @data = {}

  set: (key, response) ->
    @data[key] = response

  get: (key) ->
    @data[key]
