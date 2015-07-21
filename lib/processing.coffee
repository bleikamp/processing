{CompositeDisposable, BufferedProcess} = require 'atom'
fs = require 'fs'
path = require 'path'
psTree = require 'ps-tree'

module.exports = Processing =
  config:
    'processing-executable':
      type:"string",
      default:"processing-java"

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
    console.log("build and run time")
    editor  = atom.workspace.getActivePaneItem()
    file    = editor?.buffer.file
    folder  = file.getParent().getPath()
    build_dir = path.join(folder, "build")
    command = path.normalize(atom.config.get("processing.processing-executable"))
    args = ["--sketch=#{folder}", "--output=#{build_dir}", "--run", "--force"]
    options = {}
    console.log("Running command #{command} #{args.join(" ")}")
    stdout = (output) ->
      console.log(output)
    stderr = (output) ->
      console.error(output)
    exit = (code) ->
      console.log("Error code: #{code}")

    if @process
      psTree @process.process.pid, (err, children) =>
        for child in children
          process.kill(child.PID)
    @process = new BufferedProcess({command, args, stdout, stderr, exit})

  runSketch: ->
    @saveSketch()
    @buildSketch()
