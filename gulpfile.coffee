gulp = require('gulp')
rename = require('gulp-rename')
argv = require('yargs').argv

browserify = require('gulp-browserify')
reactify = require('reactify')

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
gulp.task 'build:scripts:jsx', ->
  gulp.src("#{paths.scripts}/*.{js,jsx}", { read: false })
    .pipe(
      browserify(
        transform: ['reactify', 'debowerify']
        extensions: ['js', 'jsx']
        debug: debug
      )
    )
    .pipe(rename(extname: '.js'))
    .pipe(gulp.dest('./public/'))

# coffee-reactifyでcoffeescript + jsxをコンパイル
gulp.task 'build:scripts:coffee', ->
  gulp.src("#{paths.scripts}/*.{coffee,cjsx}", { read: false })
    .pipe(
      browserify(
        transform: ['coffee-reactify', 'debowerify']
        extensions: ['coffee']
        debug: debug
      )
    )
    .pipe(rename(extname: '.js'))
    .pipe(gulp.dest('./public/'))

# app/stylesのビルド
gulp.task 'build:styles', ->
  # sassをsourcemap付きでコンパイル
  gulp.src("#{paths.styles}/*.{css,scss}")
    .pipe(sourcemaps.init())
    .pipe(sass())
    .pipe(sourcemaps.write())
    .pipe(gulp.dest('./public/'))

# app/assetsのビルド
gulp.task 'build:assets', ->
  # assetsはコピーするだけ
  gulp.src("#{paths.assets}/**/*")
    .pipe(gulp.dest('./public/'))

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
