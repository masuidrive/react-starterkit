# @cjsx React.DOM
React = require('react');

TodoApp = require('./flux1/components/TodoApp.coffee')

React.render(<TodoApp/>, document.getElementById('flux1'))
