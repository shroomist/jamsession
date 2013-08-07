jam = window.jam || {}

jam.InstrCtrl = class InstrCtrl
  constructor: (@instr, @name) ->
  createView: (w, stage, num) ->
    el = document.createElement('div')
    el.classList.add(@name)

    for i in [0...num] by 1
      b = document.createElement('div')
      b.innerHTML = i
      b.classList.add('note')
      b.classList.add(i)
      b.addEventListener 'touchstart', jam.app.handleTouch, false
      b.addEventListener 'touchenter', jam.app.handleTouch, false
      el.appendChild(b)
    stage.appendChild(el)


jam.Instrument = class Instrument
  constructor: (w, @name) ->
    Context = w.AudioContext || w.webkitAudioContext
    @context = new Context

  loadFiles: (urlList, BufferLoader) ->
    @sampleCount = urlList.length
    bufferLoader = new BufferLoader @context, urlList, @loadComplete.bind(this)
    bufferLoader.load()

  loadComplete: (@sounds) ->
    console.log('sounds buffered' + @sounds)

  playSound: (soundId) ->
    source = @context.createBufferSource()
    source.buffer = @sounds[soundId]
    source.connect @context.destination
    source.noteOn(0)

jam.Stage = class Stage
  constructor: (w) ->
    @instrCount = 0
    @instr = {}
    @ctrl = {}
  createViews: (w) ->
    @el = document.getElementById('stage')
    for name, instr of @instr
      @ctrl[name] = new InstrCtrl instr, name
      @ctrl[name].createView w, @el, instr.sampleCount
  addInstr: (name, soundPaths, w) ->
    @instr[name] = new Instrument w, name
    @instrCount += 1
    @instr[name].loadFiles soundPaths, w.BufferLoader
  getInstr: (name) ->
    return @instr[name]
  playInstr: (d) ->
    @getInstr(d.instr).playSound(d.note)
    return

