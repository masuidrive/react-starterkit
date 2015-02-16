# @cjsx React.DOM
React = require('react')

Hello = React.createClass
  render: ->
    <div>Hello {this.props.name}</div>

React.render(<Hello name="World" />, document.body);
