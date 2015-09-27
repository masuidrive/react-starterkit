var gulp = require('gulp');
var gulpif = require('gulp-if');
var config = require('../config');

// app/assetsのビルド
gulp.task('build:assets', function() {
  // assetsはコピーするだけ
  gulp.src(config.path.assets + "/**/*")
    .pipe(gulp.dest(config.path.dest));
});
