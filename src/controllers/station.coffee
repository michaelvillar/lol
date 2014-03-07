Model = require('model.coffee')

class Station extends Model
  constructor: (index) ->
    super
    @index = index
    @people = []

  addPeople: (people) =>
    @people = @people.concat(people)
    @trigger('station.people.changed')

  pendingPeople: =>
    @people.reduce (pv, cv) =>
      return pv + cv
    , 0

module.exports = Station
