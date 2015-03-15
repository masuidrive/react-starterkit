gulp = require('gulp')
rename = require('gulp-rename')
gulpif = require('gulp-if')
config = require('../config')

browserify = require('browserify')
through2 = require('through2')
sourcemaps = require('gulp-sourcemaps')
uglify = require('gulp-uglify')
reactify = require('reactify')
coffee_reactify = require('coffee-reactify')
debowerify = require('debowerify')

# app/scriptsのビルド
gulp.task 'build:scripts', ->
  exts = ['js', 'jsx', 'coffee', 'cjsx']

  browserified = through2.obj (file, enc, next) ->
    browserify(file.path,
      debug: config.debug
      extensions: exts
    )
    .bundle()

  gulp.src("#{config.path.scripts}/*.{#{exts.join(',')}}")
    .pipe(browserified)
    .pipe(sourcemaps.init(loadMaps: true))
    .pipe(gulpif(!config.debug, uglify()))
    .pipe(rename(extname: '.js'))
    .pipe(sourcemaps.write("."))
    .pipe(gulp.dest(config.path.dest))
