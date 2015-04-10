gulp = require('gulp')
gulpif = require('gulp-if')
config = require('../config')

sass = require('gulp-sass')
sourcemaps = require('gulp-sourcemaps')
autoprefixer = require('gulp-autoprefixer')
minifyCSS = require('gulp-minify-css')
notifier = require("node-notifier")


swallowError = (error)->
  console.log error
  notifier.notify(
    title: error.message
    message: "#{error.fileName}: #{error.lineNumber}"
  )
  @emit('end')

# app/stylesのビルド
gulp.task 'build:styles', ->
  gulp.src("#{config.path.styles}/*.{css,scss}")
    .pipe(sourcemaps.init(loadMaps: true))
    .pipe(sass())
    .on('error', swallowError)
    .pipe(autoprefixer(
      browsers: ['last 2 versions']
      cascade: false
    ))
    .pipe(sourcemaps.write("."))
    .pipe(gulpif(!config.debug, minifyCSS()))
    .pipe(gulp.dest(config.path.dest))
