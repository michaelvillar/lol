class EventDispatcher
  constructor: ->
    @callbacks = {}

  on: (eventName, callback) =>
    @callbacks[eventName] ||= []
    @callbacks[eventName].push callback

  trigger: (eventName, data) =>
    callbacks = @callbacks[eventName]
    return unless callbacks
    for callback in callbacks
      callback(data)

module.exports = EventDispatcher
