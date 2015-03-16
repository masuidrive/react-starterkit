gulp = require('gulp')
rename = require('gulp-rename')
gulpif = require('gulp-if')
config = require('../config')
glob = require("glob")

browserify = require('browserify')
through2 = require('through2')
sourcemaps = require('gulp-sourcemaps')
uglify = require('gulp-uglify')

swallowError = (error) ->
  console.log(error.message)
  @emit('end')

# app/scriptsのビルド
gulp.task 'build:scripts', ->
  exts = [ 'js', 'jsx', 'coffee', 'cjsx']

  testFiles = glob.sync("#{config.path.scripts}/*.{#{exts.join(',')}}")
  console.log testFiles
  browserify(
    entries: testFiles
    debug: config.debug
#    noParse: ['/vagrant/bower_components/flux/dist/Flux.js']
    extensions: exts
  )
  .bundle()
#  .on('error', swallowError)
  .pipe(sourcemaps.init(loadMaps: true))
  .pipe(gulpif(!config.debug, uglify()))
  .pipe(rename(extname: '.js'))
  .pipe(sourcemaps.write("."))
  .pipe(gulp.dest(config.path.dest))
