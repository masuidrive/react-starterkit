var gulp = require('gulp');
var config = require('../config');
var del = require('del');

// ファイルクリーン
gulp.task('clean', function() {
  del(config.path.dest);
});
