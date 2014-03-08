Model = require('model.coffee')
Cluster = require('cluster.coffee')

rand = (from, to) =>
  Math.round(Math.random() * (to - from) + from)

normalDistribution = (mean, stdev) =>
  random = rand(-1, 1) + rand(-1, 1) + rand(-1, 1)
  return Math.round(random * stdev + mean)

class City extends Model
  constructor: ->
    super
    @size = [100,100]

    @stations = []
    @stationsGrid = {}
    for x in [0..@size[0] - 1]
      @stationsGrid[x] = {}

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
    lowBound = 0.0075 * @size[0] * @size[1]
    highBound = 0.01 * @size[0] * @size[1]
    centersCount = 0.003 * @size[0] * @size[1]
    centers = []

    # Find first center randomly around the center of the map
    padding = 0.0015 * @size[0] * @size[1]
    centers.push([Math.min(@size[0] - 1, Math.max(0, rand(@size[0] / 2 - padding, @size[0] / 2 + padding))),
                  Math.min(@size[1] - 1, Math.max(0, rand(@size[1] / 2 - padding, @size[1] / 2 + padding)))])

    # Find other centers randomly around one another center
    while centers.length < centersCount
      centerRefIndex = rand(0, centers.length - 1)
      centerRef = centers[centerRefIndex]
      centers.push([Math.min(@size[0] - 1, Math.max(0, rand(centerRef[0] - padding, centerRef[0] + padding))),
                    Math.min(@size[1] - 1, Math.max(0, rand(centerRef[1] - padding, centerRef[1] + padding)))])

    addPeople = (i, nx, ny) =>
      # return if nx < 0 or nx >= @size[0]
      # return if ny < 0 or ny >= @size[1]
      # cluster = @clustersGrid[nx][ny]
      # r = 0.0025 * @size[0] * @size[1]
      # k = Math.max(0.01, 1 - (Math.abs(i) / r))
      # number = rand(lowBound * k, highBound * k)

      # cluster.addPeople(number)
      # @population += number
      return if nx < 0 or nx >= @size[0]
      return if ny < 0 or ny >= @size[1]
      cluster = @clustersGrid[nx][ny]
      mean = 300 - i * 6
      density = 0.8
      stddev = 150 * (1  - density) * 0.5
      number = Math.max(normalDistribution(mean, stddev), 0);
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

  populationAt: ([x, y], radius = 0) =>
    pop = 0 # @clustersGrid[x][y].population()
    for nx in [x - radius..x + radius]
      for ny in [y - radius..y + radius]
        continue if nx < 0 or nx >= @size[0]
        continue if ny < 0 or ny >= @size[1]
        continue if Math.sqrt((nx - x) * (nx - x) + (ny - y) * (ny - y)) > radius
        pop += @clustersGrid[nx][ny].population()
    pop

  priceAt: ([x, y]) =>
    @clustersGrid[x][y].price()

  addStation: (station) =>
    return if @stationsGrid[station.index[0]][station.index[1]] # We don't want two stations at the same place
    @stationsGrid[station.index[0]][station.index[1]] = station
    @stations.push(station)
    @trigger('city.station.added', station)

  stationAt: ([x, y]) =>
    @stationsGrid[x][y]

module.exports = City
