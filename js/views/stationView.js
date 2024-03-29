// Generated by CoffeeScript 1.7.1
(function() {
  var StationView, View,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  View = require('view.coffee');

  StationView = (function(_super) {
    __extends(StationView, _super);

    function StationView(station) {
      this.stationPeopleChanged = __bind(this.stationPeopleChanged, this);
      StationView.__super__.constructor.apply(this, arguments);
      this.station = station;
      this.station.on('station.people.changed', this.stationPeopleChanged);
      this.el = document.createElement('div');
      this.el.classList.add('station');
      this.el.style.left = station.index[0] * TILE_WIDTH + "px";
      this.el.style.top = station.index[1] * TILE_HEIGHT + "px";
      this.el.style.width = TILE_WIDTH + "px";
      this.el.style.height = TILE_HEIGHT + "px";
      this.peopleEl = document.createElement('div');
      this.peopleEl.classList.add('peopleBar');
      this.el.appendChild(this.peopleEl);
    }

    StationView.prototype.stationPeopleChanged = function() {
      return this.peopleEl.style.height = (this.station.pendingPeople() / 50) + 'px';
    };

    return StationView;

  })(View);

  module.exports = StationView;

}).call(this);
