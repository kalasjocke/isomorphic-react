React = require 'react'
RSVP = require 'rsvp'

Item = require './item'


{h1, h2, div, p} = React.DOM


module.exports = React.createClass
  statics:
    willTransitionTo: (transition, params, query) ->
      api = transition.routesComponent.props.api
      transition.wait(RSVP.all([
        api.get("collections/#{params.id}", 'collection'),
        api.get("collections/#{params.id}/items", 'items'),
      ]))

    willTransitionFrom: (transition, component) ->
      # TODO See if one can do loading animations here

  render: ->
    div {},
      h1 {}, @props.store.get('collection').name
      @props.store.get('items').map (item) -> Item(item: item)
