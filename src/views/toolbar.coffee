View = require('view.coffee')

class Toolbar extends View
  constructor: ->
    super
    @el = document.createElement('div')
    @el.classList.add('toolbar')

    @cashEl = document.createElement('div')
    @cashEl.classList.add('cash')
    @el.appendChild(@cashEl)

    @selected = null

    @addButton '~', =>
      @trigger('toolbar.tool.normal')
    , { selected: true }
    @addButton 'Build', =>
      @trigger('toolbar.tool.build')

  addButton: (label, action, options = {}) =>
    button = document.createElement('button')
    button.innerHTML = label
    button.addEventListener 'click', =>
      @setSelected(button)
      action()
    if options.selected
      @setSelected(button)
    @el.appendChild(button)

  setSelected: (button) =>
    @selected.classList.remove('selected') if @selected
    @selected = button
    @selected.classList.add('selected')

  setCash: (cash) =>
    @cashEl.innerHTML = cash

module.exports = Toolbar
