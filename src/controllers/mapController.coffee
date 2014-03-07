Controller = require('controller.coffee')
City = require('city.coffee')
StationView = require('stationView.coffee')

elementPos = (el) ->
  [parseInt(el.style.left, 10), parseInt(el.style.top, 10)]

class MapController extends Controller
  constructor: (@city) ->
    super
    @el = document.createElement('div')
    @el.classList.add('map')
    @tilesEl = document.createElement('div')
    @tilesEl.classList.add('tiles')
    @el.appendChild(@tilesEl)

    console.log 'population', @city.population
    avg = @city.population / @city.size[0] / @city.size[1]
    console.log 'avg', avg

    max = 0
    for cluster in @city.clusters
      max = Math.max(cluster.population(), max)
    console.log 'max', max

    @tiles = []
    for y in [0..@city.size[1] - 1]
      row = []
      @tiles.push(row)
      for x in [0..@city.size[0] - 1]
        tile = document.createElement('div')
        tile.classList.add("tile")
        tile.classList.add("tile#{x}-#{y}")
        tile.setAttribute('data-pos', "#{x},#{y}")
        tile.style.left = x * TILE_WIDTH + "px"
        tile.style.top = y * TILE_HEIGHT + "px"
        tile.style.width = TILE_WIDTH + "px"
        tile.style.height = TILE_HEIGHT + "px"
        ratio = @city.populationAt([x, y]) / max
        white = Math.round(255 * 2 * (0.5 - Math.min(0.5, ratio)))
        tile.style.backgroundColor = "rgb(255, #{Math.round(255 * (1 - ratio))}, #{white})"
        tile.addEventListener('mouseover', @tileMouseOver)
        tile.addEventListener('click', @tileClick)
        row.push(tile)
        @tilesEl.appendChild(tile)

    @city.on 'city.station.added', @cityStationAdded

  tileMouseOver: (e) =>
    tile = e.srcElement

    index = tile.getAttribute('data-pos').split(',').map(Number)
    @trigger('mapController.over', { index: index })

  tileClick: (e) =>
    tile = e.srcElement
    @selectedTile.classList.remove('selected') if @selectedTile
    if tile == @selectedTile
      @selectedTile = null
      return
    tile.classList.add('selected')
    @selectedTile = tile

    index = tile.getAttribute('data-pos').split(',').map(Number)
    @trigger('mapController.click', { index: index })

  updateWindow: (tile) =>
    return
    # pos = elementPos(tile)
    # @areaElement.style.left = pos[0] + (TILE_WIDTH / 2) - (AREA_RADIUS * TILE_WIDTH) + "px"
    # @areaElement.style.top = pos[1] + (TILE_HEIGHT / 2) - (AREA_RADIUS * TILE_HEIGHT) + "px"

    # index = tile.getAttribute('data-pos').split(',').map(Number)

    # content = "Pop: #{@city.populationAt(index)}<br>
    # Area pop: #{@city.populationAt(index, AREA_RADIUS)}<br>
    # Ground price: $#{@city.priceAt(index)}
    # "
    # @tileWindow.setContent(content)

  cityStationAdded: (station) =>
    stationView = new StationView(station)
    @el.appendChild(stationView.el)

module.exports = MapController
