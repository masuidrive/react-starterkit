# @cjsx React.DOM
# Original: Copyright (c) 2015, Facebook, Inc.
# https://github.com/facebook/flux/blob/master/examples/flux-todomvc

React = require('react')
MainSection = require('./MainSection')
TodoStore = require('../stores/TodoStore')

# Retrieve the current TODO data from the TodoStore
getTodoState = () ->
  allTodos: TodoStore.getAll()
  areAllComplete: TodoStore.areAllComplete()


TodoApp = React.createClass
  getInitialState: () ->
    getTodoState()

  componentDidMount: () ->
    TodoStore.addChangeListener(@_onChange);

  componentWillUnmount: () ->
    TodoStore.removeChangeListener(@_onChange);

  render: () ->
    <div>
      <MainSection
        allTodos={this.state.allTodos}
        areAllComplete={this.state.areAllComplete}
      />
    </div>

  _onChange: function() {
    this.setState(getTodoState())
  }

module.exports = TodoApp
