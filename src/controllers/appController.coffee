Controller = require('controller.coffee')
MapController = require('mapController.coffee')
GameController = require('gameController.coffee')
Window = require('window.coffee')
Toolbar = require('toolbar.coffee')
Station = require('station.coffee')
City = require('city.coffee')

class AppController extends Controller
  constructor: (@el) ->
    super

    @cash = 1000000
    @city = new City

    @toolbarAction = 'normal'
    @toolbar = new Toolbar
    @toolbar.on 'toolbar.tool.normal', =>
      @toolbarAction = 'normal'
    @toolbar.on 'toolbar.tool.build', =>
      @toolbarAction = 'build'
    @updateToolbarCash()

    document.body.appendChild(@toolbar.el)

    @mapController = new MapController(@city)
    @mapController.on 'mapController.click', @mapControllerClick
    @mapController.on 'mapController.over', @mapControllerOver
    document.body.appendChild(@mapController.el)

    @gameController = new GameController(@city)

    @infoWindow = new Window
    @infoWindow.show([8,56])

    # @areaElement = document.createElement('div')
    # @areaElement.classList.add('area')
    # @areaElement.style.width = TILE_WIDTH * AREA_RADIUS * 2 + "px"
    # @areaElement.style.height = TILE_HEIGHT * AREA_RADIUS * 2 + "px"
    # document.body.appendChild(@areaElement)

  mapControllerClick: (data) =>
    if @toolbarAction == 'build'
      price = @city.priceAt(data.index)
      if @cash < price
        return alert "You don't have enough money!"
      if confirm "Are you sure to build this station for $#{price}?"
        @incrementCash(-price)
        @city.addStation(new Station(data.index))

  mapControllerOver: (data) =>
    index = data.index
    content = "Pop: #{@city.populationAt(index)}<br>
    Area pop: #{@city.populationAt(index, AREA_RADIUS)}<br>
    Ground price: $#{@city.priceAt(index)}
    "

    station = @city.stationAt(index)
    if station
      content += "<br>Station<br>
      Pending people: #{station.pendingPeople()}
      "

    @infoWindow.setContent(content)

  incrementCash: (cash) =>
    @cash += cash
    @updateToolbarCash()

  updateToolbarCash: =>
    @toolbar.setCash("$" + @cash)

module.exports = AppController
