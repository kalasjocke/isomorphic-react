React = require 'react'
RSVP = require 'rsvp'
_ = require 'underscore'

Api = require './api'
PetsComponent = require './components/pets'


api = new Api()


module.exports =
  '/people/:id': (person_id) ->
    RSVP.all([
      api.get("people/#{person_id}"),
      api.get("people/#{person_id}/pets"),
    ]).then((requests) =>
      person = requests[0]['response']['people'][0]
      pets = requests[1]['response']['pets']

      [PetsComponent(person: person, pets: pets), requests]
    )
