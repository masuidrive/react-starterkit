# @cjsx React.DOM
# Original: Copyright (c) 2015, Facebook, Inc.
# https://github.com/facebook/flux/blob/master/examples/flux-todomvc

React = require('react')
TodoActions = require('../actions/TodoActions.coffee')
TodoTextInput = require('./TodoTextInput.coffee')

Header = React.createClass
  render: ->
    <header id="header">
      <h1>todos</h1>
      <TodoTextInput
        id="new-todo"
        placeholder="What needs to be done?"
        onSave={@_onSave}
      />
    </header>

  # Event handler called within TodoTextInput.
  # Defining this here allows TodoTextInput to be used in multiple places
  # in different ways.
  # @param {string} text
  _onSave: (text) ->
    if text.trim()
      TodoActions.create(text)

module.exports = Header
