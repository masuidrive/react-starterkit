gulp = require('gulp')
config = require('../config')

# 配布用設定
gulp.task 'dist:confg', ->
  config.debug = false
  config.path.dest = config.path.dist

# 配布用ビルド
gulp.task 'dist:build', [
    'dist:confg',
    'clean',
    'build'
  ]
