// Generated by CoffeeScript 1.4.0
(function() {
  var EventDispatcher,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  EventDispatcher = (function() {

    function EventDispatcher() {
      this.trigger = __bind(this.trigger, this);

      this.on = __bind(this.on, this);
      this.callbacks = {};
    }

    EventDispatcher.prototype.on = function(eventName, callback) {
      var _base;
      (_base = this.callbacks)[eventName] || (_base[eventName] = []);
      return this.callbacks[eventName].push(callback);
    };

    EventDispatcher.prototype.trigger = function(eventName, data) {
      var callback, callbacks, _i, _len, _results;
      callbacks = this.callbacks[eventName];
      if (!callbacks) {
        return;
      }
      _results = [];
      for (_i = 0, _len = callbacks.length; _i < _len; _i++) {
        callback = callbacks[_i];
        _results.push(callback(data));
      }
      return _results;
    };

    return EventDispatcher;

  })();

  module.exports = EventDispatcher;

}).call(this);