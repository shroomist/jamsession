
jam = window.jam || {}

jam.touchable = document.ontouchstart == null

initSocket = () ->
  socket = io.connect jam.conf.ioAddr
  socket.on 'status', (data) ->
    console.log data
  socket.on 'note', (data) ->
    playInstr data
    return

  return socket

jam.app = {
  init: ->
    jam.stage = new jam.Stage window
    jam.stage.addInstr 'drum', jam.conf.drumPath, window
    jam.stage.addInstr 'dub', jam.conf.dubPath, window
    jam.stage.addInstr 'pipa', jam.conf.pipaPath, window
    jam.sock = initSocket()
    return

  postLoad: ->
    jam.stage.createViews()
  }

jam.app.handleTouch = (evt, el) ->
  instrName = evt.target.parentNode.className
  noteNum = parseInt evt.target.className.slice(-1), 10
  data = { instr: instrName, note: noteNum }
  jam.stage.playInstr data
  jam.sock.emit 'note', data
  return

jam.app.init()

window.onload = () ->
  jam.app.postLoad(window)
