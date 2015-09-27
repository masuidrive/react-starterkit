var path = require('path');
var gulp = require('gulp');
var rename = require('gulp-rename');
var gulpif = require('gulp-if');
var transform = require('vinyl-transform');
var through2 = require('through2');
var notifier = require("node-notifier");

var browserify = require('browserify');
var babelify = require('babelify');
var sourcemaps = require('gulp-sourcemaps');
var uglify = require('gulp-uglify');

var config = require('../config');

var swallowError = function(error) {
  return function(error) {
    console.log(error);
    notifier.notify({
      title: "React",
      message: error
    });
    this.emit('end');
  };
};

// app/scriptsのビルド
gulp.task('build:scripts', function() {
/*
  browserify('./app/scripts/example2.jsx', { debug: true })
    .bundle()
    .on("error", function (err) { console.log("Error : " + err.message); })
    .pipe(source('example2.js'))
    .pipe(gulp.dest('./public'))
*/
  var exts = ['js', 'jsx'];

  gulp.src(config.path.scripts + '/*.{' + exts.join(',') + '}')
  .pipe(through2.obj(function(file, encode, callback){
    return browserify(file.path, {
      debug: config.debug
    })
    .bundle(function(err, res){
      file.contents = res;
      callback(null, file)
    })
    .on('error', swallowError(file.path));
  }))
  .pipe(sourcemaps.init({loadMaps: true}))
  .pipe(gulpif(!config.debug, uglify()))
  .pipe(rename({extname: '.js'}))
  .pipe(sourcemaps.write("."))
  .pipe(gulp.dest(config.path.dest));
});
