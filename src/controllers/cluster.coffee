class Cluster
  constructor: (@people = []) ->

  addPeople: (people = []) ->
    @people = @people.concat(people)

  population: =>
    @people.reduce (pv, cv) =>
      return pv + cv
    , 0

module.exports = Cluster
