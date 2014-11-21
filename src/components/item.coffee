React = require 'react'


{div, p, img} = React.DOM

module.exports = React.createClass
  render: ->
    div {},
      if @props.item.type == 'store'
        p {}, 'Store'
      else
        p {}, 'Product'
