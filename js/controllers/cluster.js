// Generated by CoffeeScript 1.4.0
(function() {
  var Cluster,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  Cluster = (function() {

    function Cluster(people) {
      this.people = people != null ? people : [];
      this.population = __bind(this.population, this);

    }

    Cluster.prototype.addPeople = function(people) {
      if (people == null) {
        people = [];
      }
      return this.people = this.people.concat(people);
    };

    Cluster.prototype.population = function() {
      var _this = this;
      return this.people.reduce(function(pv, cv) {
        return pv + cv;
      }, 0);
    };

    return Cluster;

  })();

  module.exports = Cluster;

}).call(this);
