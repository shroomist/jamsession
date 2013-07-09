
jam = window.jam || {}

jam.app = {
  init: ->
    jam.stage = new jam.Stage window
    jam.stage.addInstr 'drum', jam.conf.drumPath, window
  }
jam.app.init()

window.onload = () ->
  document.getElementById('kik').onclick = () ->
    jam.stage.getInstr('drum').playSound(0)
  document.getElementById('snare').onclick = () ->
    jam.stage.getInstr('drum').playSound(1)
  document.getElementById('hihat').onclick = () ->
    jam.stage.getInstr('drum').playSound(2)
