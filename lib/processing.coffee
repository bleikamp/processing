{CompositeDisposable} = require 'atom'

module.exports = Processing =
  activate: (state) ->
    atom.commands.add 'atom-workspace',
      'processing:run': =>
        @runSketch()

  saveSketch: ->
    file = atom.workspace.getActivePaneItem()
    file?.save()
    return

  buildSketch: ->
    exec   = require('child_process').exec
    editor = atom.workspace.getActivePaneItem()
    path   = editor?.buffer.file.path
    arr    = path.split "/"
    folder = arr[0..arr.length-2].join "/"
    command = "
      processing-java
      --sketch=#{folder}
      --output=#{folder}/build
      --run
      --force
    "

    console.log folder

    exec command, (error, stdout, stderr) ->
      if error
          console.log error.stack
          console.log "Error code: #{error.code}"
          console.log "Signal: #{error.signal}"
        console.log "STDOUT: #{stdout}"
        console.log "STDERR: #{stderr}"

  runSketch: ->
    @saveSketch()
    @buildSketch()
    return
