module.exports =
  isServer: ->
    not window?

  isClient: ->
    window?
