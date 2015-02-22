gulp = require('gulp')
rename = require('gulp-rename')
gulpif = require('gulp-if')
config = require('../config')

browserify = require('gulp-browserify')
sourcemaps = require('gulp-sourcemaps')
uglify = require('gulp-uglify')


# app/scriptsのビルド
gulp.task 'build:scripts', [
    'build:scripts:jsx'
    'build:scripts:coffee'
  ]


# JSXはreactifyでコンパイル
# debowerifyでbowerのrequireをサポート
# --env "production"の場合、sourcemapを付けない
gulp.task 'build:scripts:jsx', ->
  gulp.src("#{config.path.scripts}/*.{js,jsx}", { read: false })
    .pipe(
      browserify(
        transform: ['reactify', 'debowerify']
        extensions: ['js', 'jsx']
        debug: config.debug
      )
    )
    .pipe(gulpif(!config.debug, uglify()))
    .pipe(rename(extname: '.js'))
    .pipe(gulp.dest(config.path.dest))


# coffee-reactifyでcoffeescript + jsxをコンパイル
gulp.task 'build:scripts:coffee', ->
  gulp.src("#{config.path.scripts}/*.{coffee,cjsx}", { read: false })
    .pipe(
      browserify(
        transform: ['coffee-reactify', 'debowerify']
        extensions: ['coffee']
        debug: config.debug
      )
    )
    .pipe(gulpif(!config.debug, uglify()))
    .pipe(rename(extname: '.js'))
    .pipe(gulp.dest(config.path.dest))
