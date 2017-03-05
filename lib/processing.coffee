{CompositeDisposable, BufferedProcess} = require 'atom'
fs = require 'fs'
path = require 'path'
psTree = require 'ps-tree'
ProcessingView = require './processing-view'

module.exports = Processing =
  config:
    'processing-executable':
      type:"string",
      default:"processing-java"

  activate: (state) ->
    atom.commands.add 'atom-workspace', 'processing:run': =>
      @runSketch()
    atom.commands.add 'atom-workspace', 'processing:present': =>
      @runSketchPresent()
    atom.commands.add 'atom-workspace', 'processing:close': =>
      @closeSketch()

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
    name    = file?.getBaseName()

    if name.includes('.pde')
      folder  = file.getParent().getPath()
      build_dir = path.join(folder, "build-tmp")
      command = path.normalize(atom.config.get("processing.processing-executable"))
      args = ["--force", "--sketch=#{folder}", "--output=#{build_dir}", "--run"]
      options = {}
      console.log("Running command #{command} #{args.join(" ")}")
      stdout = (output) => @display output
      stderr = (output) => @display output
      exit = (code) ->
        console.log("Error code: #{code}")
      if !@view
        @view = new ProcessingView
        atom.workspace.addBottomPanel(item: @view)
      else
        atom.workspace.panelForItem(@view).show()
      if @process
        psTree @process.process.pid, (err, children) =>
          for child in children
            process.kill(child.PID)
        @view.clear()
      @process = new BufferedProcess({command, args, stdout, stderr, exit})
    else
      if @view
        atom.workspace.panelForItem(@view).hide()


  runSketch: ->
    @saveSketch()
    @buildSketch()

  display: (line) ->
    @view.log(line)

  closeSketch: ->
    if @view
      @view.clear()
    if @process
      psTree @process.process.pid, (err, children) =>
        for child in children
          process.kill(child.PID)
