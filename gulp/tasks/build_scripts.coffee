gulp = require('gulp')
rename = require('gulp-rename')
gulpif = require('gulp-if')
glob = require("glob")
buffer = require('vinyl-buffer')
source = require('vinyl-source-stream')
transform = require('vinyl-transform')

browserify = require('browserify')
sourcemaps = require('gulp-sourcemaps')
uglify = require('gulp-uglify')

config = require('../config')

swallowError = (error) ->
  console.log(error.message)
  @emit('end')

# app/scriptsのビルド
gulp.task 'build:scripts', ->
  exts = [ 'js', 'jsx', 'coffee', 'cjsx']

  gulp.src("#{config.path.scripts}/*.{#{exts.join(',')}}")
  .pipe(transform (filename) ->
    browserify(
      entries: filename
      debug: config.debug
      extensions: exts
      # requireの処理をしないファイル
      noParse: ['/vagrant/bower_components/flux/dist/Flux.js']
    )
    .bundle()
  )
  .pipe(sourcemaps.init(loadMaps: true))
  .pipe(gulpif(!config.debug, uglify()))
  .pipe(rename(extname: '.js'))
  .pipe(sourcemaps.write("."))
  .pipe(gulp.dest(config.path.dest))
