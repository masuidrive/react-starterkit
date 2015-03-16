gulp = require('gulp')
rename = require('gulp-rename')
gulpif = require('gulp-if')
config = require('../config')
glob = require("glob")


browserify = require('browserify')
through2 = require('through2')
sourcemaps = require('gulp-sourcemaps')
uglify = require('gulp-uglify')

# app/scriptsのビルド
gulp.task 'build:scripts', ->
  exts = [ 'js', 'jsx', 'coffee', 'cjsx']

  testFiles = glob.sync("#{config.path.scripts}/*.coffee")
  console.log(testFiles)
  browserify(#file.path,
    entries: testFiles
    debug: config.debug
    extensions: exts
  )
  .bundle()
  .pipe(sourcemaps.init(loadMaps: true))
  .pipe(gulpif(!config.debug, uglify()))
  .pipe(rename(extname: '.js'))
  .pipe(sourcemaps.write("."))
  .pipe(gulp.dest(config.path.dest))


a = ->
  browserified = through2.obj (file, enc, next) ->
    console.log file
    browserify(file.path,
      debug: config.debug
      extensions: exts
    )
    .bundle (err, buffer) ->
      if err
        next(err)
      else
        file.contents = buffer
        next(null, file)

  gulp.src(exts.map (ext) -> "#{config.path.scripts}/*.#{ext}")
    .pipe(browserified)
    .pipe(sourcemaps.init(loadMaps: true))
    .pipe(gulpif(!config.debug, uglify()))
    .pipe(rename(extname: '.js'))
    .pipe(sourcemaps.write("."))
    .pipe(gulp.dest(config.path.dest))
