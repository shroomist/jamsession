jam = window.jam || {}

jam.Instrument = class Instrument
  constructor: (w, @name) ->
    Context = w.AudioContext || w.webkitAudioContext
    @context = new Context

  loadFiles: (urlList, BufferLoader) ->
    console.dir BufferLoader
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
  addInstr: (name, soundPaths, w) ->
    @instr[name] = new Instrument w, name
    @instrCount += 1
    @instr[name].loadFiles soundPaths, w.BufferLoader
  getInstr: (name) ->
    return @instr[name]

