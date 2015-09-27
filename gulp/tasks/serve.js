var gulp = require('gulp');
var config = require('../config');

var express = require('express');

// HTTPサーバを起動
gulp.task('serve', function() {
  server = express()
  server.use(express.static(config.path.dest));
  server.listen(config.port)
});
