path = require('path')
gulp = require('gulp')
rename = require('gulp-rename')
gulpif = require('gulp-if')
transform = require('vinyl-transform')
notifier = require("node-notifier")

browserify = require('browserify')
sourcemaps = require('gulp-sourcemaps')
uglify = require('gulp-uglify')

config = require('../config')

swallowError = (error) ->
  notifier.notify(
    message: error.message
    title: error.plugin
  )
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
      noParse: [
        'bower_components/flux/dist/Flux.js'
        'bower_components/react/react.js'
        'bower_components/react/react-with-addons.js'
      ].map (f) -> path.resolve(f)
    )
    # 互換性のためのshimを登録
    .add("./vendor/assets/javascripts/shim.coffee")
    .bundle()
    .on('error', swallowError)
  )
  .pipe(sourcemaps.init(loadMaps: true))
  .pipe(gulpif(!config.debug, uglify()))
  .pipe(rename(extname: '.js'))
  .pipe(sourcemaps.write("."))
  .pipe(gulp.dest(config.path.dest))
