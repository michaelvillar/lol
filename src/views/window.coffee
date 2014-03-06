class Window
  constructor: ->
    @el = document.createElement('div')
    @el.classList.add('window')
    @size = [220, 30]

  show: (pos) =>
    @el.style.left = pos[0] + "px"
    @el.style.top = pos[1] + "px"
    document.body.appendChild(@el)

  setContent: (content) =>
    @el.innerHTML = "<p>" + content + "</p>"

module.exports = Window
