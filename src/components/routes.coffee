React = require 'react'
Router = require 'react-router'
{Route, Routes, DefaultRoute} = Router

App = require './app'
Collections = require './collections'
Collection = require './collection'


module.exports = (api, store) ->
  Routes location: 'history', api: api, [
    Route name: 'app', path: '/', handler: App, [
      DefaultRoute name: 'collections', handler: Collections, store: store
      Route name: 'collection', path: '/collections/:id', handler: Collection, store: store
    ]
  ]
