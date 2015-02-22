gulp = require('gulp')
gulpif = require('gulp-if')
config = require('../config')

sass = require('gulp-sass')
sourcemaps = require('gulp-sourcemaps')
autoprefixer = require('gulp-autoprefixer')
minifyCSS = require('gulp-minify-css')


# app/stylesのビルド
gulp.task 'build:styles', ->
  gulp.src("#{config.path.styles}/*.{css,scss}")
    .pipe(gulpif(config.debug, sourcemaps.init()))
    .pipe(sass())
    .pipe(gulpif(config.debug, sourcemaps.write()))
    .pipe(autoprefixer(
      browsers: ['last 2 versions']
      cascade: false
    ))
    .pipe(gulpif(!config.debug, minifyCSS()))
    .pipe(gulp.dest(config.path.dest))
