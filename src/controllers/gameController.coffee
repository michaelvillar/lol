Controller = require('controller.coffee')

class GameController extends Controller
  constructor: (@city) ->
    setInterval @loop, 1000

  loop: =>
    for station in @city.stations
      station.addPeople([10])

module.exports = GameController
