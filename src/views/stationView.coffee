View = require('view.coffee')

class StationView extends View
  constructor: (station) ->
    super
    @station = station
    @station.on 'station.people.changed', @stationPeopleChanged

    @el = document.createElement('div')
    @el.classList.add('station')
    @el.style.left = station.index[0] * TILE_WIDTH + "px"
    @el.style.top = station.index[1] * TILE_HEIGHT + "px"
    @el.style.width = TILE_WIDTH + "px"
    @el.style.height = TILE_HEIGHT + "px"

    @peopleEl = document.createElement('div')
    @peopleEl.classList.add('peopleBar')
    @el.appendChild(@peopleEl)

  stationPeopleChanged: =>
    @peopleEl.style.height = (@station.pendingPeople() / 50) + 'px'

module.exports = StationView
