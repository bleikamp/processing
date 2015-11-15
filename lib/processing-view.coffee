{View, $$} = require 'atom-space-pen-views'

module.exports =
class ProcessingView extends View

  @content: ->
    @div =>
      # Display layout and outlets
      css = 'tool-panel panel panel-bottom padding script-view native-key-bindings'
      @div class: css, outlet: 'script', tabindex: -1, =>
        @div class: 'panel-body padded output', outlet: 'output'
  log: (line) ->
    #console.log(line);
    @output.append $$ ->
      @pre class: "line", =>
        @raw line
    height = @script[0].scrollHeight;
    @script.scrollTop(height);
  clear: ->
    @output.empty()
