gulp = require('gulp')
config = require('../config')

express = require('express')

# HTTPサーバを起動
gulp.task 'serve', ->
  server = express()
  server.use(express.static(config.path.dest));
  server.listen(config.port)
