var gulp = require('gulp');
var config = require('../config');

// HTTPサーバを起動しつつ、変更を監視
gulp.task('dev', ['serve', 'watch']);
