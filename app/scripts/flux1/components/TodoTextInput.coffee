# @cjsx React.DOM
# Original: Copyright (c) 2015, Facebook, Inc.
# https://github.com/facebook/flux/blob/master/examples/flux-todomvc

React = require('react')
ReactPropTypes = React.PropTypes

ENTER_KEY_CODE = 13

TodoTextInput = React.createClass

  propTypes: {
    className: ReactPropTypes.string,
    id: ReactPropTypes.string,
    placeholder: ReactPropTypes.string,
    onSave: ReactPropTypes.func.isRequired,
    value: ReactPropTypes.string
  }

  getInitialState: ->
    value: @props.value || ''

  render: ->
    <input
      className={@props.className}
      id={@props.id}
      placeholder={@props.placeholder}
      onBlur={@_save}
      onChange={@_onChange}
      onKeyDown={@_onKeyDown}
      value={@state.value}
      autoFocus={true}
    />

  # Invokes the callback passed in as onSave, allowing this component to be
  # used in different ways.
  _save: ->
    @props.onSave(@state.value)
    @setState(value: '')

  _onChange: (event) ->
    @setState(value: event.target.value)

  _onKeyDown: (event) ->
    @_save() if event.keyCode == ENTER_KEY_CODE


module.exports = TodoTextInput
