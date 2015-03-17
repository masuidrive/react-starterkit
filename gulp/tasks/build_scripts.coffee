path = require('path')
gulp = require('gulp')
rename = require('gulp-rename')
gulpif = require('gulp-if')
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
      noParse: [
        'bower_components/flux/dist/Flux.js'
        'bower_components/react/react.js'
        'bower_components/react/react-with-addons.js'
      ].map (f) -> path.resolve(f)
    )
    .bundle()
    .on('error', swallowError)
  )
  .pipe(sourcemaps.init(loadMaps: true))
  .pipe(gulpif(!config.debug, uglify()))
  .pipe(rename(extname: '.js'))
  .pipe(sourcemaps.write("."))
  .pipe(gulp.dest(config.path.dest))
