// Generated by CoffeeScript 1.7.1
(function() {
  var Controller, GameController,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Controller = require('controller.coffee');

  GameController = (function(_super) {
    __extends(GameController, _super);

    function GameController(city) {
      this.city = city;
      this.loop = __bind(this.loop, this);
      setInterval(this.loop, 1000);
    }

    GameController.prototype.loop = function() {
      var station, _i, _len, _ref, _results;
      _ref = this.city.stations;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        station = _ref[_i];
        _results.push(station.addPeople([10]));
      }
      return _results;
    };

    return GameController;

  })(Controller);

  module.exports = GameController;

}).call(this);
