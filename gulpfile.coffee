gulp = require('gulp')
rename = require('gulp-rename')
argv = require('yargs').argv
clean = require('gulp-clean')

browserify = require('gulp-browserify')

sass = require('gulp-sass')
sourcemaps = require('gulp-sourcemaps')

express = require('express')
server_port = 8000

paths =
    scripts: './app/scripts'
    styles: './app/styles'
    assets: './app/assets'

debug = (argv.env != 'production')

# app/scriptsのビルド
gulp.task 'build:scripts', ['build:scripts:jsx', 'build:scripts:coffee']

# JSXはreactifyでコンパイル
# debowerifyでbowerのrequireをサポート
# --env "production"の場合、sourcemapを付けない
task_build_scripts_jsx = (options = {}) ->
  gulp.src("#{paths.scripts}/*.{js,jsx}", { read: false })
    .pipe(
      browserify(
        transform: ['reactify', 'debowerify']
        extensions: ['js', 'jsx']
        debug: options.debug ? debug
      )
    )
    .pipe(rename(extname: '.js'))
    .pipe(gulp.dest(options.dest ? './public/'))

gulp.task 'build:scripts:jsx', ->
  task_build_scripts_jsx()


# coffee-reactifyでcoffeescript + jsxをコンパイル
task_build_scripts_coffee = (options = {}) ->
  gulp.src("#{paths.scripts}/*.{coffee,cjsx}", { read: false })
    .pipe(
      browserify(
        transform: ['coffee-reactify', 'debowerify']
        extensions: ['coffee']
        debug: options.debug ? debug
      )
    )
    .pipe(rename(extname: '.js'))
    .pipe(gulp.dest(options.dest ? './public/'))

gulp.task 'build:scripts:coffee', ->
  task_build_scripts_coffee()


# app/stylesのビルド
task_build_styles = (options = {}) ->
  # sassをsourcemap付きでコンパイル
  gulp.src("#{paths.styles}/*.{css,scss}")
    .pipe(sourcemaps.init())
    .pipe(sass())
    .pipe(sourcemaps.write())
    .pipe(gulp.dest(options.dest ? './public/'))

gulp.task 'build:styles', ->
  task_build_styles()

# app/assetsのビルド
task_build_assets = (options = {}) ->
  # assetsはコピーするだけ
  gulp.src("#{paths.assets}/**/*")
    .pipe(gulp.dest(options.dest ? './public/'))

gulp.task 'build:assets', (options) ->
  task_build_assets()


# ファイルクリーン
task_clean = (options = {}) ->
  gulp.src(options.dest ? './public/', {read: false})
    .pipe(clean())

gulp.task 'clean', (options) ->
  task_clean()


gulp.task 'build', [
    'build:scripts'
    'build:styles'
    'build:assets'
  ]


# HTTPサーバを起動
gulp.task 'serve', ->
  server = express()
  server.use(express.static('./public'));
  server.listen(server_port)

# ファイルの変更を監視してビルド
gulp.task 'watch', ['build'], ->
    gulp.watch "#{paths.scripts}/**/*.{js,jsx,coffee,cjsx}", ['build:scripts']
    gulp.watch "#{paths.styles}/**/*.{css,scss}", ['build:styles']
    gulp.watch "#{paths.assets}/**/*", ['build:assets']

# HTTPサーバを起動しつつ、変更を監視
gulp.task 'dev', ['serve', 'watch'], ->


# 配布用ビルド
gulp.task 'dist:build', ->
  options =
    debug: false
    dest: "./dist/"
  task_clean(options)
  task_build_scripts_jsx(options)
  task_build_scripts_coffee(options)
  task_build_styles(options)
  task_build_assets(options)
