React = require 'react'

Router = require 'react-router'
{Link} = Router


{div} = React.DOM


module.exports = React.createClass
  render: ->
    div {},
      @props.activeRouteHandler()
