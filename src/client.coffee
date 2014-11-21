React = require 'react'

Api = require './api'
Store = require './store'
routesFactory = require './components/routes'

store = new Store()
api = new Api(store, false, window.BOOTSTRAP)

React.renderComponent(routesFactory(api, store), document.querySelector('#app'))
