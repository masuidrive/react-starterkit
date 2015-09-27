var gulp = require('gulp');
var gulpif = require('gulp-if');
var config = require('../config');

var sass = require('gulp-sass');
var sourcemaps = require('gulp-sourcemaps');
var autoprefixer = require('gulp-autoprefixer');
var minifyCSS = require('gulp-minify-css');
var notifier = require("node-notifier");


var swallowError = function (error) {
  console.log(error);
  notifier.notify({
    title: error.message,
    message: error.fileName + ': ' + error.lineNumber
  });
  this.emit('end');
};

// app/stylesのビルド
gulp.task('build:styles', function() {
  gulp.src(config.path.styles + "/*.{css,scss}")
    .pipe(sourcemaps.init({loadMaps: true}))
    .pipe(sass())
    .on('error', swallowError)
    .pipe(autoprefixer({
      browsers: ['last 2 versions'],
      cascade: false
    }))
    .pipe(sourcemaps.write("."))
    .pipe(gulpif(!config.debug, minifyCSS()))
    .pipe(gulp.dest(config.path.dest))
});
