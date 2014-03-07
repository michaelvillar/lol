// Generated by CoffeeScript 1.4.0
(function() {
  var Toolbar, View,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  View = require('view.coffee');

  Toolbar = (function(_super) {

    __extends(Toolbar, _super);

    function Toolbar() {
      this.setCash = __bind(this.setCash, this);

      this.setSelected = __bind(this.setSelected, this);

      this.addButton = __bind(this.addButton, this);

      var _this = this;
      Toolbar.__super__.constructor.apply(this, arguments);
      this.el = document.createElement('div');
      this.el.classList.add('toolbar');
      this.cashEl = document.createElement('div');
      this.cashEl.classList.add('cash');
      this.el.appendChild(this.cashEl);
      this.selected = null;
      this.addButton('~', function() {
        return _this.trigger('toolbar.tool.normal');
      }, {
        selected: true
      });
      this.addButton('Build', function() {
        return _this.trigger('toolbar.tool.build');
      });
    }

    Toolbar.prototype.addButton = function(label, action, options) {
      var button,
        _this = this;
      if (options == null) {
        options = {};
      }
      button = document.createElement('button');
      button.innerHTML = label;
      button.addEventListener('click', function() {
        _this.setSelected(button);
        return action();
      });
      if (options.selected) {
        this.setSelected(button);
      }
      return this.el.appendChild(button);
    };

    Toolbar.prototype.setSelected = function(button) {
      if (this.selected) {
        this.selected.classList.remove('selected');
      }
      this.selected = button;
      return this.selected.classList.add('selected');
    };

    Toolbar.prototype.setCash = function(cash) {
      return this.cashEl.innerHTML = cash;
    };

    return Toolbar;

  })(View);

  module.exports = Toolbar;

}).call(this);