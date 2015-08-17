'use strict';

var gulp = require('gulp');

gulp.paths = {
  serve      : ['./bower_components', './build'],
  cjsxSrc    : './src/**/*.cjsx',
  sassSrc    : './src/**/*.scss',
  htmlSrc    : './src/*.html',
  build      : './build',
  buildFiles : './build/**/*'
}

require('require-dir')('./gulp');

gulp.task('default', function() {
  gulp.start('serve');
});