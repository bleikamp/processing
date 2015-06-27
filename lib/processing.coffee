{CompositeDisposable} = require 'atom'
fs = require 'fs'

module.exports = Processing =
  activate: (state) ->
    atom.commands.add 'atom-workspace', 'processing:run': =>
      @runSketch()

  saveSketch: ->
    editor = atom.workspace.getActivePaneItem()
    file = editor?.buffer.file

    if file?.existsSync()
      editor.save()
    else
      num = Math.floor(Math.random() * 10000)
      dir = fs.mkdirSync("/tmp/sketch_#{num}/")
      editor.saveAs("/tmp/sketch_#{num}/sketch_#{num}.pde")

  buildSketch: ->
    exec    = require('child_process').exec
    editor  = atom.workspace.getActivePaneItem()
    file    = editor?.buffer.file
    filepath= file.getPath()
    folder  = file.getParent().getPath()
    command = "processing-java --sketch=#{folder} --output=#{folder}/build --run --force"

    exec command, (error, stdout, stderr) ->
      if error
          console.log error.stack
          console.log "Error code: #{error.code}"
          console.log "Signal: #{error.signal}"
        console.log "PROCESSING: \n #{stdout} \n #{stderr}"

  runSketch: ->
    @saveSketch()
    @buildSketch()
