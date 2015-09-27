var gulp = require('gulp');
var config = require('../config');

// 全ビルド
gulp.task('build', [
  'build:scripts',
  'build:styles',
  'build:assets'
]);
