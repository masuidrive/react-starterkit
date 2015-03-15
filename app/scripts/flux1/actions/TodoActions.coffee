# Original: Copyright (c) 2015, Facebook, Inc.
# https://github.com/facebook/flux/blob/master/examples/flux-todomvc
AppDispatcher = require('../dispatcher/AppDispatcher')
TodoConstants = require('../constants/TodoConstants')

TodoActions =
  # @param  {string} text
  create: (text) ->
    AppDispatcher.dispatch
      actionType: TodoConstants.TODO_CREATE
      text: text

  # @param  {string} id The ID of the ToDo item
  # @param  {string} text
  updateText: (id, text) ->
    AppDispatcher.dispatch
      actionType: TodoConstants.TODO_UPDATE_TEXT
      id: id
      text: text

  # Toggle whether a single ToDo is complete
  # @param  {object} todo
  toggleComplete: (todo) ->
    if todo.complete
      AppDispatcher.dispatch
        actionType: TodoConstants.TODO_UNDO_COMPLETE
        id: todo.id
    else
      AppDispatcher.dispatch
        actionType: TodoConstants.TODO_COMPLETE
        id: todo.id

  # Mark all ToDos as complete
  toggleCompleteAll: ->
    AppDispatcher.dispatch
      actionType: TodoConstants.TODO_TOGGLE_COMPLETE_ALL

  # @param  {string} id
  destroy: (id) ->
    AppDispatcher.dispatch
      actionType: TodoConstants.TODO_DESTROY
      id: id

  # Delete all the completed ToDos
  destroyCompleted: ->
    AppDispatcher.dispatch
      actionType: TodoConstants.TODO_DESTROY_COMPLETED

module.exports = TodoActions
