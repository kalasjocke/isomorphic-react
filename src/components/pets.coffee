React = require 'react'

Link = require './link'


{h1, h2, div, ul, li} = React.DOM

module.exports = React.createClass
  render: ->
    div {},
      h1 {}, @props.person.name
      Link {href: '/people/5442afceaa7088ea1ecdca61'}, "Joakim"
      Link {href: '/people/5442b0f1aa7088ea1ecdca62'}, "Johannes"
      ul {},
        for pet in @props.pets
          li {}, pet.name
