# @cjsx React.DOM
# Original: Copyright (c) 2015, Facebook, Inc.
# https://github.com/facebook/flux/blob/master/examples/flux-todomvc

React = require('react')
ReactPropTypes = React.PropTypes
cx = React.addons.classSet
TodoActions = require('../actions/TodoActions.coffee')
TodoTextInput = require('./TodoTextInput.coffee')

TodoItem = React.createClass

  propTypes: {
   todo: ReactPropTypes.object.isRequired
  }

  getInitialState: ->
    isEditing: false

  render: ->
    todo = this.props.todo

    if @state.isEditing
      input =
        <TodoTextInput
          className="edit"
          onSave={@_onSave}
          value={todo.text}
        />

    # List items should get the class 'editing' when editing
    # and 'completed' when marked as completed.
    # Note that 'completed' is a classification while 'complete' is a state.
    # This differentiation between classification and state becomes important
    # in the naming of view actions toggleComplete() vs. destroyCompleted().
    <li
      className={cx({
        'completed': todo.complete,
        'editing': @state.isEditing
      })}
      key={todo.id}>
      <div className="view">
        <input
          className="toggle"
          type="checkbox"
          checked={todo.complete}
          onChange={@_onToggleComplete}
        />
        <label onDoubleClick={@_onDoubleClick}>
          {todo.text}
        </label>
        <button className="destroy" onClick={@_onDestroyClick} />
      </div>
      {input}
    </li>

  _onToggleComplete: ->
    TodoActions.toggleComplete(@props.todo)

  _onDoubleClick: ->
    @setState(isEditing: true)

  # Event handler called within TodoTextInput.
  # Defining this here allows TodoTextInput to be used in multiple places
  # in different ways.
  # @param  {string} text
  _onSave: (text) ->
    TodoActions.updateText(@props.todo.id, text)
    @setState(isEditing: false)

  _onDestroyClick: ->
    TodoActions.destroy(@props.todo.id)


module.exports = TodoItem
