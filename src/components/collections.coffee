React = require 'react'
Router = require 'react-router'
Link = Router.Link
RSVP = require 'rsvp'


{h1, div, ul, li} = React.DOM


module.exports = React.createClass
  statics:
    willTransitionTo: (transition, params, query) ->
      api = transition.routesComponent.props.api
      transition.wait(api.get('collections', 'collections'))

    willTransitionFrom: () ->
      console.log "ON MY WAY OUT!"

  render: ->
    div {},
      h1 {}, "Collections"
      ul {},
        @props.store.get('collections').map (collection) ->
          li {}, Link(to: 'collection', params: id: collection.id, collection.name)
