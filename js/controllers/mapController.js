// Generated by CoffeeScript 1.4.0
(function() {
  var City, Controller, MapController, StationView, elementPos,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Controller = require('controller.coffee');

  City = require('city.coffee');

  StationView = require('stationView.coffee');

  elementPos = function(el) {
    return [parseInt(el.style.left, 10), parseInt(el.style.top, 10)];
  };

  MapController = (function(_super) {

    __extends(MapController, _super);

    function MapController(city) {
      var avg, cluster, max, ratio, row, tile, white, x, y, _i, _j, _k, _len, _ref, _ref1, _ref2;
      this.city = city;
      this.cityStationAdded = __bind(this.cityStationAdded, this);

      this.updateWindow = __bind(this.updateWindow, this);

      this.tileClick = __bind(this.tileClick, this);

      this.tileMouseOver = __bind(this.tileMouseOver, this);

      MapController.__super__.constructor.apply(this, arguments);
      this.el = document.createElement('div');
      this.el.classList.add('map');
      this.tilesEl = document.createElement('div');
      this.tilesEl.classList.add('tiles');
      this.el.appendChild(this.tilesEl);
      console.log('population', this.city.population);
      avg = this.city.population / this.city.size[0] / this.city.size[1];
      console.log('avg', avg);
      max = 0;
      _ref = this.city.clusters;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        cluster = _ref[_i];
        max = Math.max(cluster.population(), max);
      }
      console.log('max', max);
      this.tiles = [];
      for (y = _j = 0, _ref1 = this.city.size[1] - 1; 0 <= _ref1 ? _j <= _ref1 : _j >= _ref1; y = 0 <= _ref1 ? ++_j : --_j) {
        row = [];
        this.tiles.push(row);
        for (x = _k = 0, _ref2 = this.city.size[0] - 1; 0 <= _ref2 ? _k <= _ref2 : _k >= _ref2; x = 0 <= _ref2 ? ++_k : --_k) {
          tile = document.createElement('div');
          tile.classList.add("tile");
          tile.classList.add("tile" + x + "-" + y);
          tile.setAttribute('data-pos', "" + x + "," + y);
          tile.style.left = x * TILE_WIDTH + "px";
          tile.style.top = y * TILE_HEIGHT + "px";
          tile.style.width = TILE_WIDTH + "px";
          tile.style.height = TILE_HEIGHT + "px";
          ratio = this.city.populationAt([x, y]) / max;
          white = Math.round(255 * 2 * (0.5 - Math.min(0.5, ratio)));
          tile.style.backgroundColor = "rgb(255, " + (Math.round(255 * (1 - ratio))) + ", " + white + ")";
          tile.addEventListener('mouseover', this.tileMouseOver);
          tile.addEventListener('click', this.tileClick);
          row.push(tile);
          this.tilesEl.appendChild(tile);
        }
      }
      this.city.on('city.station.added', this.cityStationAdded);
    }

    MapController.prototype.tileMouseOver = function(e) {
      var index, tile;
      tile = e.srcElement;
      index = tile.getAttribute('data-pos').split(',').map(Number);
      return this.trigger('mapController.over', {
        index: index
      });
    };

    MapController.prototype.tileClick = function(e) {
      var index, tile;
      tile = e.srcElement;
      if (this.selectedTile) {
        this.selectedTile.classList.remove('selected');
      }
      if (tile === this.selectedTile) {
        this.selectedTile = null;
        return;
      }
      tile.classList.add('selected');
      this.selectedTile = tile;
      index = tile.getAttribute('data-pos').split(',').map(Number);
      return this.trigger('mapController.click', {
        index: index
      });
    };

    MapController.prototype.updateWindow = function(tile) {};

    MapController.prototype.cityStationAdded = function(station) {
      var stationView;
      stationView = new StationView(station);
      return this.el.appendChild(stationView.el);
    };

    return MapController;

  })(Controller);

  module.exports = MapController;

}).call(this);
