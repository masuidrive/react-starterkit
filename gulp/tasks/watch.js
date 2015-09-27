var gulp = require('gulp');
var config = require('../config');

// ファイルの変更を監視してビルド
gulp.task('watch', ['build'], function() {
  gulp.watch(config.path.scripts+"/**/*.{js,jsx,coffee,cjsx}", ['build:scripts']);
  gulp.watch(config.path.styles+"/**/*.{css,scss}", ['build:styles']);
  gulp.watch(config.path.assets+"/**/*", ['build:assets']);
});
