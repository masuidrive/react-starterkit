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
gulp.task 'build:scripts', [
    'build:scripts:jsx'
    'build:scripts:coffee'
  ]


# JSXはreactifyでコンパイル
# debowerifyでbowerのrequireをサポート
# --env "production"の場合、minifyしない
gulp.task 'build:scripts:jsx', ->
  browserified = through2.obj (file, enc, next) ->
    browserify(file.path,
      debug: config.debug
      extensions: ['js', 'jsx']
    )
    .transform(reactify)
    .transform(debowerify)
    .bundle (err, res) ->
      if err
        next(err)
      else
        file.contents = res
        next(null, file)

  gulp.src("#{config.path.scripts}/*.{js,jsx}")
    .pipe(browserified)
    .pipe(sourcemaps.init(loadMaps: true))
    .pipe(gulpif(!config.debug, uglify()))
    .pipe(rename(extname: '.js'))
    .pipe(sourcemaps.write("."))
    .pipe(gulp.dest(config.path.dest))


# coffee-reactifyでcoffeescript + jsxをコンパイル
gulp.task 'build:scripts:coffee', ->
  browserified = through2.obj (file, enc, next) ->
    browserify(file.path,
      debug: config.debug
      extensions: ['coffee', 'cjsx']
    )
    .transform(coffee_reactify)
    .transform(debowerify)
    .bundle (err, res) ->
      if err
        next(err)
      else
        file.contents = res
        next(null, file)

  gulp.src("#{config.path.scripts}/*.{coffee,cjsx}")
    .pipe(browserified)
    .pipe(sourcemaps.init(loadMaps: true))
    .pipe(gulpif(!config.debug, uglify()))
    .pipe(rename(extname: '.js'))
    .pipe(sourcemaps.write("."))
    .pipe(gulp.dest(config.path.dest))
