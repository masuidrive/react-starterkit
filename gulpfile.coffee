gulp = require('gulp')
rename = require('gulp-rename')
browserify = require('gulp-browserify')
sass = require('gulp-sass')


files =
    scripts: './app/scripts/*.{js,coffee}'
    styles: './app/styles/*.{css,scss}'
    assets: './app/assets/**/*'

gulp.task 'compile:scripts', ->
  gulp.src(files.scripts, { read: false })
    .pipe(
      browserify(
        transform: ['coffee-reactify']
        extensions: ['.coffee', 'js']
        debug: true
      )
    )
    .pipe(rename(extname: '.js'))
    .pipe(gulp.dest('./public/'))

gulp.task 'compile:styles', ->
  gulp.src(files.styles)
    .pipe(sass())
    .pipe(gulp.dest('./public/'))

gulp.task 'compile:assets', ->
  gulp.src(files.assets)
    .pipe(gulp.dest('./public/'))

gulp.task 'watch', ['compile'], ->
    gulp.watch files.scripts, ['compile:scripts']
    gulp.watch files.styles, ['compile:styles']
    gulp.watch files.assets, ['compile:assets']

gulp.task 'compile', ->
  gulp.run('compile:scripts')
  gulp.run('compile:styles')
  gulp.run('compile:assets')
