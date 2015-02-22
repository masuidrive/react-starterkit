gulp = require('gulp')
config = require('../config')
del = require('del')

# ファイルクリーン
gulp.task 'clean', ->
  del(config.path.dest)
