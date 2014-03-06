class Cluster
  constructor: (@people = []) ->

  addPeople: (people = []) ->
    @people = @people.concat(people)

  population: =>
    @people.reduce (pv, cv) =>
      return pv + cv
    , 0

  price: =>
    Math.ceil(@population() * 13.3 / 500) * 500

module.exports = Cluster
