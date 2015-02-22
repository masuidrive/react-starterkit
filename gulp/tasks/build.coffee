gulp = require('gulp')
config = require('../config')

# 全ビルド
gulp.task 'build', [
    'build:scripts'
    'build:styles'
    'build:assets'
  ]
