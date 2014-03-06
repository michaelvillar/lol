City = require('city.coffee')

TILE_WIDTH = 10
TILE_HEIGHT = 10

class AppController
  constructor: (@el) ->
    @city = new City
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
        tile.style.left = x * TILE_WIDTH + "px"
        tile.style.top = y * TILE_HEIGHT + "px"
        tile.style.width = TILE_WIDTH + "px"
        tile.style.height = TILE_HEIGHT + "px"
        ratio = @city.populationAt(x, y) / max
        white = Math.round(255 * 2 * (0.5 - Math.min(0.5, ratio)))
        tile.style.backgroundColor = "rgb(255, #{Math.round(255 * (1 - ratio))}, #{white})"
        row.push(tile)
        @el.appendChild(tile)

module.exports = AppController
