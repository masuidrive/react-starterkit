gulp = require('gulp')
gulpif = require('gulp-if')
config = require('../config')

# app/assetsのビルド
gulp.task 'build:assets', ->
  # assetsはコピーするだけ
  gulp.src("#{config.path.assets}/**/*")
    .pipe(gulp.dest(config.path.dest))
