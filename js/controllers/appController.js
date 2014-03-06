// Generated by CoffeeScript 1.4.0
(function() {
  var AppController, City, TILE_HEIGHT, TILE_WIDTH;

  City = require('city.coffee');

  TILE_WIDTH = 10;

  TILE_HEIGHT = 10;

  AppController = (function() {

    function AppController(el) {
      var avg, cluster, max, ratio, row, tile, white, x, y, _i, _j, _k, _len, _ref, _ref1, _ref2;
      this.el = el;
      this.city = new City;
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
          tile.style.left = x * TILE_WIDTH + "px";
          tile.style.top = y * TILE_HEIGHT + "px";
          tile.style.width = TILE_WIDTH + "px";
          tile.style.height = TILE_HEIGHT + "px";
          ratio = this.city.populationAt(x, y) / max;
          white = Math.round(255 * 2 * (0.5 - Math.min(0.5, ratio)));
          tile.style.backgroundColor = "rgb(255, " + (Math.round(255 * (1 - ratio))) + ", " + white + ")";
          row.push(tile);
          this.el.appendChild(tile);
        }
      }
    }

    return AppController;

  })();

  module.exports = AppController;

}).call(this);
