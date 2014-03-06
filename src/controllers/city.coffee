Cluster = require('cluster.coffee')

rand = (from, to) =>
  Math.round(Math.random() * (to - from) + from)

class City
  constructor: ->
    @size = [100,60]

    @clusters = []
    @clustersGrid = []
    for x in [0..@size[0] - 1]
      row = []
      @clustersGrid.push(row)
      for y in [0..@size[1] - 1]
        cluster = new Cluster([])
        @clusters.push(cluster)
        row.push(cluster)

    @distribute()

  distribute: =>
    @population = 0
    lowBound = 0.075 * @size[0] * @size[1]
    highBound = 0.1 * @size[0] * @size[1]
    centersCount = 0.003 * @size[0] * @size[1]
    centers = []

    # Find first center randomly around the center of the map
    padding = 0.0035 * @size[0] * @size[1]
    centers.push([Math.min(@size[0] - 1, Math.max(0, rand(@size[0] / 2 - padding, @size[0] / 2 + padding))),
                  Math.min(@size[1] - 1, Math.max(0, rand(@size[1] / 2 - padding, @size[1] / 2 + padding)))])

    # Find other centers randomly around one another center
    while centers.length < centersCount
      centerRefIndex = rand(0, centers.length - 1)
      centerRef = centers[centerRefIndex]
      centers.push([Math.min(@size[0] - 1, Math.max(0, rand(centerRef[0] - padding, centerRef[0] + padding))),
                    Math.min(@size[1] - 1, Math.max(0, rand(centerRef[1] - padding, centerRef[1] + padding)))])

    addPeople = (i, nx, ny) =>
      return if nx < 0 or nx >= @size[0]
      return if ny < 0 or ny >= @size[1]
      cluster = @clustersGrid[nx][ny]
      k = Math.max(0.01, 1 - (Math.abs(i) / 25))
      number = rand(lowBound * k, highBound * k)

      cluster.addPeople(number)
      @population += number

    for center in centers
      number = rand(lowBound, highBound)
      cluster = @clustersGrid[center[0]][center[1]]

      cluster.addPeople(number)
      @population += number

      for i in [1..100]
        for x in [-i,i]
          for y in [-i..i]
            nx = center[0] + x
            ny = center[1] + y
            addPeople(Math.sqrt(x * x + y * y), nx, ny)
        for x in [-i + 1..i - 1]
          for y in [-i,i]
            nx = center[0] + x
            ny = center[1] + y
            addPeople(Math.sqrt(x * x + y * y), nx, ny)

  populationAt: ([x, y]) =>
    @clustersGrid[x][y].population()

  priceAt: ([x, y]) =>
    @clustersGrid[x][y].price()

module.exports = City
