{CompositeDisposable} = require 'atom'
fs = require 'fs'

module.exports = Processing =
  activate: (state) ->
    atom.commands.add 'atom-workspace', 'processing:run': =>
      @runSketch()

  saveSketch: ->
    file = atom.workspace.getActivePaneItem()
    file?.save()

  buildSketch: ->
    exec    = require('child_process').exec
    editor  = atom.workspace.getActivePaneItem()
    file    = editor?.buffer.file
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
