React = require 'react'
merge = require 'react/lib/merge'

router = require '../router'


module.exports = React.createClass
  onClick: ->
    router.setRoute(@props.href)
    false

  render: ->
    props = merge(@props, {
      href: @props.href,
      onClick: @onClick,
    })

    React.DOM.a props, @props.children
