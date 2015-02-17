# @cjsx React.DOM
React = require('react')

Hello = React.createClass
  render: ->
    <div>Hello {this.props.name}</div>

React.render(<Hello name="Coffee" />, document.getElementById("example1"));
