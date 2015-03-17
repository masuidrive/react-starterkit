# @cjsx React.DOM
# Original: Copyright (c) 2015, Facebook, Inc.
# https://github.com/facebook/flux/blob/master/examples/flux-todomvc

React = require('react')
ReactPropTypes = React.PropTypes
TodoActions = require('../actions/TodoActions.coffee')
TodoItem = require('./TodoItem.coffee')

MainSection = React.createClass

  propTypes: {
    allTodos: ReactPropTypes.object.isRequired,
    areAllComplete: ReactPropTypes.bool.isRequired
  }

  render: ->
    # This section should be hidden by default
    # and shown when there are todos.
    allTodos = this.props.allTodos
    todos = []
    for key, todo of allTodos
      todos.push(<TodoItem key={key} todo={todo} />)

    <section id="main">
      <input
        id="toggle-all"
        type="checkbox"
        onChange={@_onToggleCompleteAll}
        checked={@props.areAllComplete ? 'checked' : ''}
      />
      <label htmlFor="toggle-all">Mark all as complete</label>
      <ul id="todo-list">{todos}</ul>
    </section>

  # Event handler to mark all TODOs as complete
  _onToggleCompleteAll: ->
    TodoActions.toggleCompleteAll()


module.exports = MainSection
